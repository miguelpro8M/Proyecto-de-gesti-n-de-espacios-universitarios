<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"
         import="java.util.List, org.example.modelo.Reporte" %>

<%!
    // Evita que texto escrito por el usuario se interprete como HTML
    private String esc(String texto) {
        if (texto == null) {
            return "";
        }
        return texto.replace("&", "&amp;").replace("<", "&lt;")
                    .replace(">", "&gt;").replace("\"", "&quot;");
    }

    private String clasePrioridad(String prioridad) {
        if (prioridad.equals("Alta")) {
            return "prioridad-alta";
        }
        if (prioridad.equals("Media")) {
            return "prioridad-media";
        }
        return "prioridad-baja";
    }
%>
<%
    String ctx = request.getContextPath();

    // Mensajes que llegan por URL cuando ReporteServlet termina de procesar el formulario
    String ok = request.getParameter("ok");
    String error = request.getParameter("error");

    boolean registrado = ok != null && ok.matches("REP-\\d+");

    String mensajeError = null;
    if ("campos".equals(error)) {
        mensajeError = "Todos los campos son obligatorios.";
    } else if ("invalido".equals(error)) {
        mensajeError = "Alguno de los datos enviados no es válido.";
    } else if ("largo".equals(error)) {
        mensajeError = "La descripción no puede superar los 500 caracteres.";
    }

    // Nombres para el segundo select (lo llena reportes.js segun el tipo de espacio)
    String[] nombresSalones = {"A-101", "A-102", "A-201", "B-101", "B-201", "C-301", "C-302", "C-303"};
    String[] nombresZonas = {"Cancha 1", "Cancha 2", "Cancha 3", "Cancha 4", "Gimnasio",
                             "Zona de ping-pong", "Bolirana", "Juegos recreativos", "Biblioteca"};

    // Los reportes los consulto ReporteServlet a la base de datos (mediante el EJB)
    List<Reporte> reportes = (List<Reporte>) request.getAttribute("reportes");
%>
<!DOCTYPE html>
<html lang="es">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Reportes | Gestión de Espacios</title>
    <link rel="stylesheet" href="<%= ctx %>/estilos.css">
    <link rel="stylesheet" href="<%= ctx %>/reportes/reportes.css">
    <style>
        .mensaje-exito, .mensaje-error {
            padding: 12px 16px;
            border-radius: 8px;
            margin-bottom: 16px;
            font-weight: bold;
        }
        .mensaje-exito { background-color: #d9f5df; color: #176b2c; }
        .mensaje-error { background-color: #f8d7da; color: #842029; }
    </style>
</head>
<body>

    <main class="reportes-container">

        <jsp:include page="/header.jsp">
            <jsp:param name="modulo" value="reportes" />
            <jsp:param name="titulo" value="Reportes" />
            <jsp:param name="subtitulo" value="Registro de novedades en aulas y espacios" />
        </jsp:include>

        <section class="reportes-introduccion">
            <h2>Registrar un reporte</h2>
            <p>
                Utilice este formulario para informar sobre daños,
                problemas o novedades encontradas en los espacios de la universidad.
            </p>
        </section>

        <section class="formulario-reporte">

            <% if (registrado) { %>
            <p class="mensaje-exito">
                Reporte registrado correctamente. Número de reporte: <%= esc(ok) %>
            </p>
            <% } %>

            <% if (mensajeError != null) { %>
            <p class="mensaje-error"><%= mensajeError %></p>
            <% } %>

            <!-- El formulario se envia por POST a ReporteServlet -->
            <form id="formularioReporte" method="post" action="<%= ctx %>/reportes">

                <div class="campo-reporte">
                    <label for="tipoEspacio">Tipo de espacio</label>
                    <select id="tipoEspacio" name="tipoEspacio" required>
                        <option value="">Seleccione una opción</option>
                        <option value="Salón">Salón</option>
                        <option value="Zona recreativa">Zona recreativa</option>
                    </select>
                </div>

                <!-- Las opciones las llena reportes.js a partir de estos data- -->
                <div class="campo-reporte">
                    <label for="espacio">Espacio</label>
                    <select id="espacio" name="espacio" required disabled
                            data-salones="<%= esc(String.join("|", nombresSalones)) %>"
                            data-zonas="<%= esc(String.join("|", nombresZonas)) %>">
                        <option value="">Primero seleccione el tipo de espacio</option>
                    </select>
                </div>

                <div class="campo-reporte">
                    <label for="tipoReporte">Tipo de reporte</label>
                    <select id="tipoReporte" name="tipoReporte" required>
                        <option value="">Seleccione una opción</option>
                        <option value="Daño o avería">Daño o avería</option>
                        <option value="Limpieza">Limpieza</option>
                        <option value="Problema con equipos">Problema con equipos</option>
                        <option value="Problema con mobiliario">Problema con mobiliario</option>
                        <option value="Otro">Otro</option>
                    </select>
                </div>

                <div class="campo-reporte">
                    <label for="prioridad">Prioridad</label>
                    <select id="prioridad" name="prioridad" required>
                        <option value="">Seleccione una opción</option>
                        <option value="Baja">Baja</option>
                        <option value="Media">Media</option>
                        <option value="Alta">Alta</option>
                    </select>
                </div>

                <div class="campo-reporte campo-completo">
                    <label for="descripcion">Descripción del problema</label>
                    <textarea id="descripcion" name="descripcion" rows="6" maxlength="500" required
                              placeholder="Describa detalladamente la novedad encontrada..."></textarea>
                </div>

                <div class="botones-reporte">
                    <button type="reset" class="btn-cancelar">Limpiar</button>
                    <button type="submit" class="btn-enviar">Enviar reporte</button>
                </div>

            </form>
        </section>

        <section class="reportes-recientes">

            <h2>Reportes registrados</h2>

            <div id="listaReportes">

                <% if (reportes == null || reportes.isEmpty()) { %>

                    <p class="sin-reportes">No hay reportes registrados todavía.</p>

                <% } else { %>
                    <% for (Reporte r : reportes) { %>
                    <article class="tarjeta-reporte">

                        <div class="reporte-cabecera">
                            <h3><%= r.getNumero() %></h3>
                            <span class="estado-reporte"><%= r.getEstado() %></span>
                        </div>

                        <p><strong>Información:</strong> <%= esc(r.mostrarInformacion()) %></p>
                        <p><strong>Tipo de reporte:</strong> <%= esc(r.getTipoReporte()) %></p>
                        <p>
                            <strong>Prioridad:</strong>
                            <span class="<%= clasePrioridad(r.getPrioridad()) %>"><%= esc(r.getPrioridad()) %></span>
                        </p>
                        <p><strong>Descripción:</strong> <%= esc(r.getDescripcion()) %></p>
                        <p class="fecha-reporte">
                            Registrado el <%= r.getFecha() %> a las <%= r.getHora() %>
                        </p>

                    </article>
                    <% } %>
                <% } %>

            </div>

        </section>

    </main>

    <script src="<%= ctx %>/reportes/reportes.js"></script>

</body>
</html>