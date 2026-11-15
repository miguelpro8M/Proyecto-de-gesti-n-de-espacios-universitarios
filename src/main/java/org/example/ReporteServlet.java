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
import java.util.Date;
import java.util.List;
import java.util.stream.Collectors;

// Servlet -> EJB -> JPA -> MySQL. El servlet prepara los datos y la JSP (con JSTL) solo los muestra
@WebServlet(name = "ReporteServlet", urlPatterns = "/reportes")
public class ReporteServlet extends HttpServlet {

    private static final List<String> TIPOS_ESPACIO = List.of("Salón", "Zona recreativa");
    private static final List<String> TIPOS_REPORTE = List.of(
            "Daño o avería", "Limpieza", "Problema con equipos", "Problema con mobiliario", "Otro");
    private static final List<String> PRIORIDADES = List.of("Alta", "Media", "Baja");

    // Nombres que usa el segundo select del formulario
    private static final List<String> NOMBRES_SALONES = List.of(
            "A-101", "A-102", "A-201", "B-101", "B-201", "C-301", "C-302", "C-303");
    private static final List<String> NOMBRES_ZONAS = List.of(
            "Cancha 1", "Cancha 2", "Cancha 3", "Cancha 4", "Gimnasio",
            "Zona de ping-pong", "Bolirana", "Juegos recreativos", "Biblioteca");

    // El servidor inyecta el EJB: el servlet no abre conexiones ni crea EntityManager
    @EJB
    private ReporteService servicio;

    // GET: consulta los reportes, calcula los datos y los envia a la JSP
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        if (!haySesion(request)) {
            response.sendRedirect(request.getContextPath() + "/login.jsp");
            return;
        }

        // Todos los reportes (sirven para las estadisticas)
        List<Reporte> todos = servicio.listar();

        // Filtro opcional: /reportes?prioridad=Alta (si el valor no es valido, se ignora)
        String prioridad = limpiar(request.getParameter("prioridad"));
        List<Reporte> reportes = todos;

        if (PRIORIDADES.contains(prioridad)) {
            reportes = todos.stream()
                    .filter(r -> r.getPrioridad().equals(prioridad))
                    .collect(Collectors.toList());
        }

        // Estadistica: fraccion de reportes con prioridad alta (la JSP la formatea como porcentaje)
        long totalAlta = todos.stream().filter(r -> r.getPrioridad().equals("Alta")).count();
        double porcentajeAlta = todos.isEmpty() ? 0 : (double) totalAlta / todos.size();

        // Numero del reporte recien creado (llega en la URL despues de registrar)
        String ok = limpiar(request.getParameter("ok"));
        if (ok.matches("REP-\\d+")) {
            request.setAttribute("numeroRegistrado", ok);
        }

        // Datos para la JSP
        request.setAttribute("reportes", reportes);
        request.setAttribute("total", todos.size());
        request.setAttribute("porcentajeAlta", porcentajeAlta);
        request.setAttribute("prioridades", PRIORIDADES);
        request.setAttribute("fechaActual", new Date());
        request.setAttribute("espaciosSalones", String.join("|", NOMBRES_SALONES));
        request.setAttribute("espaciosZonas", String.join("|", NOMBRES_ZONAS));

        request.getRequestDispatcher("/WEB-INF/vistas/reportes.jsp")
                .forward(request, response);
    }

    // POST: valida el formulario y registra el reporte mediante el EJB
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

        // Registro: el EJB usa JPA para guardar el reporte en la base de datos
        Reporte reporte = servicio.crear(tipoEspacio, espacio, tipoReporte, prioridad, descripcion);

        // Redirige para que al recargar la pagina no se envie otro reporte
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