package org.example;

import jakarta.servlet.ServletContext;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

import java.io.IOException;
import java.net.URLEncoder;
import java.nio.charset.StandardCharsets;
import java.time.LocalDateTime;
import java.time.format.DateTimeFormatter;
import java.util.List;
import java.util.concurrent.CopyOnWriteArrayList;

@WebServlet(name = "ReporteServlet", urlPatterns = "/registrar-reporte")
public class ReporteServlet extends HttpServlet {

    private static final List<String> TIPOS_ESPACIO = List.of("Salón", "Zona recreativa");
    private static final List<String> TIPOS_REPORTE = List.of(
            "Daño o avería", "Limpieza", "Problema con equipos", "Problema con mobiliario", "Otro");
    private static final List<String> PRIORIDADES = List.of("Baja", "Media", "Alta");

    @Override
    @SuppressWarnings("unchecked")
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        request.setCharacterEncoding("UTF-8");

        // Sesion: sin usuario en la sesion no se puede registrar nada
        HttpSession sesion = request.getSession(false);
        if (sesion == null || sesion.getAttribute("usuario") == null) {
            response.sendRedirect(request.getContextPath() + "/login.jsp");
            return;
        }

        String tipoEspacio = limpiar(request.getParameter("tipoEspacio"));
        String espacio = limpiar(request.getParameter("espacio"));
        String tipoReporte = limpiar(request.getParameter("tipoReporte"));
        String prioridad = limpiar(request.getParameter("prioridad"));
        String descripcion = limpiar(request.getParameter("descripcion"));

        String pagina = request.getContextPath() + "/reportes/reportes.jsp";

        if (tipoEspacio.isEmpty() || espacio.isEmpty() || tipoReporte.isEmpty()
                || prioridad.isEmpty() || descripcion.isEmpty()) {
            response.sendRedirect(pagina + "?error=campos");
            return;
        }
        if (!TIPOS_ESPACIO.contains(tipoEspacio) || !TIPOS_REPORTE.contains(tipoReporte)
                || !PRIORIDADES.contains(prioridad)) {
            response.sendRedirect(pagina + "?error=invalido");
            return;
        }
        if (descripcion.length() > 500) {
            response.sendRedirect(pagina + "?error=largo");
            return;
        }


        ServletContext contexto = getServletContext();
        String numero;

        synchronized (this) {
            List<String[]> reportes = (List<String[]>) contexto.getAttribute("reportes");

            if (reportes == null) {
                reportes = new CopyOnWriteArrayList<>();
                contexto.setAttribute("reportes", reportes);
            }

            // REP-0001, REP-0002, ...
            numero = "REP-" + String.format("%04d", reportes.size() + 1);

            LocalDateTime ahora = LocalDateTime.now();
            String fecha = ahora.format(DateTimeFormatter.ofPattern("dd/MM/yyyy"));
            String hora = ahora.format(DateTimeFormatter.ofPattern("HH:mm"));


            reportes.add(new String[]{numero, tipoEspacio, espacio, tipoReporte,
                    prioridad, descripcion, fecha, hora, "Pendiente"});
        }

        response.sendRedirect(pagina + "?ok=" + URLEncoder.encode(numero, StandardCharsets.UTF_8));
    }

    private String limpiar(String valor) {
        return valor == null ? "" : valor.trim();
    }
}
