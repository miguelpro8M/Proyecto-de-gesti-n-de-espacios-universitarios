<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"
         errorPage="/error.jsp"
         import="java.util.List, org.example.Salon, org.example.SalonDAO" %>

<%-- Sesion: si no hay usuario en la sesion, este archivo redirige al login --%>
<%@ include file="/WEB-INF/sesion.jspf" %>

<%-- Comentario JSP: lo elimina Tomcat al traducir la pagina, NO llega al navegador --%>

<%!
    // Declaracion: pasa a ser miembro de la clase servlet que Tomcat genera
    private int contadorVisitas = 0;

    private String claseEstado(Salon s) {
        return s.isDisponible() ? "disponible" : "ocupado";
    }

    private String textoBoton(Salon s) {
        return s.isDisponible() ? "Reservar salón" : "Liberar salón";
    }

    // Evita que texto escrito por el usuario se interprete como HTML
    private String esc(String texto) {
        if (texto == null) {
            return "";
        }
        return texto.replace("&", "&amp;").replace("<", "&lt;")
                    .replace(">", "&gt;").replace("\"", "&quot;");
    }
%>

<%
    // Scriptlet: se ejecuta en cada solicitud
    contadorVisitas++;

    String ctx = request.getContextPath();

    // Filtros que el usuario tenia antes de reservar o liberar (llegan por la URL)
    String buscar = request.getParameter("buscar");
    String edificioSel = request.getParameter("edificio");
    String tipoSel = request.getParameter("tipo");

    if (buscar == null) {
        buscar = "";
    }
    if (edificioSel == null || edificioSel.isBlank()) {
        edificioSel = "todos";
    }
    if (tipoSel == null || tipoSel.isBlank()) {
        tipoSel = "todos";
    }

    // DAO: consulta los salones en la base de datos.
    // Si la consulta falla, la excepcion se envia a error.jsp (errorPage).
    List<Salon> salones = new SalonDAO().listar();

    String[][] edificios = {
        {"todos", "Todos"}, {"A", "Edificio A"}, {"B", "Edificio B"}, {"C", "Edificio C"}
    };
    String[][] tipos = {
        {"todos", "Todos"}, {"aula", "Aula"}, {"computadores", "Sala de computadores"},
        {"laboratorio", "Laboratorio"}, {"auditorio", "Auditorio"}
    };

    int disponibles = 0;
    for (Salon s : salones) {
        if (s.isDisponible()) {
            disponibles++;
        }
    }
%>
<!DOCTYPE html>
<html lang="es">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Salones | Gestión de Espacios</title>
    <link rel="stylesheet" href="<%= ctx %>/estilos.css">
    <link rel="stylesheet" href="<%= ctx %>/salones/salones.css">
</head>
<body>

    <!-- Comentario HTML: SI llega al navegador (se ve con Ctrl+U) -->

    <main class="salones-container">

        <jsp:include page="/header.jsp">
            <jsp:param name="titulo" value="Salones" />
            <jsp:param name="subtitulo" value="Gestión y consulta de aulas universitarias" />
        </jsp:include>

        <section class="salones-introduccion">
            <h2>Consulta de salones</h2>
            <p>Busque y consulte la información de los salones disponibles en la universidad.</p>
        </section>

        <!-- Filtros: los aplica salones.js en el navegador -->
        <section class="filtros">

            <div class="filtro">
                <label for="buscar">Buscar salón</label>
                <input type="text" id="buscar" placeholder="Ejemplo: A-101"
                       value="<%= esc(buscar) %>">
            </div>

            <div class="filtro">
                <label for="edificio">Edificio</label>
                <select id="edificio">
                    <% for (String[] e : edificios) { %>
                    <option value="<%= e[0] %>" <%= e[0].equals(edificioSel) ? "selected" : "" %>><%= e[1] %></option>
                    <% } %>
                </select>
            </div>

            <div class="filtro">
                <label for="tipo">Tipo de salón</label>
                <select id="tipo">
                    <% for (String[] t : tipos) { %>
                    <option value="<%= t[0] %>" <%= t[0].equals(tipoSel) ? "selected" : "" %>><%= t[1] %></option>
                    <% } %>
                </select>
            </div>

        </section>

        <p class="contador-disponibles">
            <span id="contadorDisponibles"><%= disponibles %> de <%= salones.size() %> salones disponibles</span>
            &nbsp;|&nbsp; Usuario activo: <%= esc(usuarioSesion) %>
            &nbsp;|&nbsp; Visitas a esta página: <%= contadorVisitas %>
        </p>

        <section class="lista-salones">
            <% for (Salon s : salones) { %>
            <article class="salon"
                     data-nombre="<%= s.getNombre() %>"
                     data-edificio="<%= s.getEdificio() %>"
                     data-tipo="<%= s.getTipo() %>"
                     data-estado="<%= s.getEstado() %>">

                <div class="salon-icono">🏫</div>

                <div class="salon-informacion">
                    <h3>
                        <a href="<%= ctx %>/consulta-salon?nombre=<%= s.getNombre() %>"
                           style="color:inherit; text-decoration:none;">Salón <%= s.getNombre() %></a>
                    </h3>
                    <p><strong>Edificio:</strong> <%= s.getEdificio() %></p>
                    <p><strong>Piso:</strong> <%= s.getPiso() %></p>
                    <p><strong>Tipo:</strong> <%= s.getTipoNombre() %></p>
                    <p><strong>Capacidad:</strong> <%= s.getCapacidad() %> personas</p>

                    <!-- POST a SalonServlet: reservar o liberar -->
                    <form method="post" action="<%= ctx %>/cambiar-estado" class="form-estado" style="margin:0;">
                        <input type="hidden" name="nombre" value="<%= s.getNombre() %>">
                        <input type="hidden" name="buscar" value="">
                        <input type="hidden" name="edificio" value="todos">
                        <input type="hidden" name="tipo" value="todos">
                        <button type="submit" class="btn-estado-salon"><%= textoBoton(s) %></button>
                    </form>
                </div>

                <div class="estado <%= claseEstado(s) %>"><%= s.getEstado() %></div>

            </article>
            <% } %>
        </section>

        <p id="sinResultados" class="sin-resultados">
            No se encontraron salones con los criterios seleccionados
        </p>

    </main>

    <script src="<%= ctx %>/salones/salones.js"></script>

</body>
</html>