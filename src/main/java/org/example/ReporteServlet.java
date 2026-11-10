package org.example;

import jakarta.ejb.EJB;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import org.example.modelo.Reporte;
import org.example.servicio.ReporteService;

import java.io.IOException;
import java.net.URLEncoder;
import java.nio.charset.StandardCharsets;
import java.util.List;

@WebServlet(name = "ReporteServlet", urlPatterns = "/reportes")
public class ReporteServlet extends HttpServlet {

    private static final List<String> TIPOS_ESPACIO = List.of("Salón", "Zona recreativa");
    private static final List<String> TIPOS_REPORTE = List.of(
            "Daño o avería", "Limpieza", "Problema con equipos", "Problema con mobiliario", "Otro");
    private static final List<String> PRIORIDADES = List.of("Baja", "Media", "Alta");

    @EJB
    private ReporteService servicio;

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        if (!haySesion(request)) {
            response.sendRedirect(request.getContextPath() + "/login.jsp");
            return;
        }

        request.setAttribute("reportes", servicio.listar());

        request.getRequestDispatcher("/WEB-INF/vistas/reportes.jsp")
                .forward(request, response);
    }

    // valida el formulario y registra el reporte mediante el EJB
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        request.setCharacterEncoding("UTF-8");

        if (!haySesion(request)) {
            response.sendRedirect(request.getContextPath() + "/login.jsp");
            return;
        }

        String tipoEspacio = limpiar(request.getParameter("tipoEspacio"));
        String espacio = limpiar(request.getParameter("espacio"));
        String tipoReporte = limpiar(request.getParameter("tipoReporte"));
        String prioridad = limpiar(request.getParameter("prioridad"));
        String descripcion = limpiar(request.getParameter("descripcion"));

        String pagina = request.getContextPath() + "/reportes";

        // Validaciones: si algo falla, no se guarda nada
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

        Reporte reporte = servicio.crear(tipoEspacio, espacio, tipoReporte, prioridad, descripcion);

        response.sendRedirect(pagina + "?ok="
                + URLEncoder.encode(reporte.getNumero(), StandardCharsets.UTF_8));
    }

    private boolean haySesion(HttpServletRequest request) {
        HttpSession sesion = request.getSession(false);
        return sesion != null && sesion.getAttribute("usuario") != null;
    }

    private String limpiar(String valor) {
        return valor == null ? "" : valor.trim();
    }
}