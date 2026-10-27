<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ include file="/WEB-INF/sesion.jspf" %>
<%
    String ctx = request.getContextPath();

    String[][] tipos = {
        {"todos", "Todos"}, {"deportiva", "Deportiva"}, {"gimnasio", "Gimnasio"},
        {"recreativa", "Recreativa"}, {"descanso", "Descanso"}
    };

    // 0 nombre | 1 tipo (clave) | 2 tipo (texto) | 3 ubicacion | 4 capacidad | 5 estado | 6 icono
    String[][] zonas = {
        {"Cancha 1", "deportiva", "Deportiva", "Zona deportiva", "20", "Disponible", "🏟️"},
        {"Cancha 2", "deportiva", "Deportiva", "Zona deportiva", "20", "Disponible", "🏟️"},
        {"Cancha 3", "deportiva", "Deportiva", "Zona deportiva", "20", "Ocupado", "🏟️"},
        {"Cancha 4", "deportiva", "Deportiva", "Zona deportiva", "20", "Disponible", "🏟️"},
        {"Gimnasio", "gimnasio", "Gimnasio", "Zona deportiva", "30", "Disponible", "🏋️"},
        {"Zona de ping-pong", "recreativa", "Recreativa", "Zona recreativa", "6", "Disponible", "🏓"},
        {"Bolirana", "recreativa", "Recreativa", "Zona recreativa", "10", "Disponible", "🎯"},
        {"Juegos recreativos", "recreativa", "Recreativa", "Zona recreativa", "10", "Disponible", "🎲"},
        {"Biblioteca", "descanso", "Biblioteca", "Edificio principal", "50", "Disponible", "📚"}
    };
%>
<!DOCTYPE html>
<html lang="es">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Zonas Recreativas | Gestión de Espacios</title>
    <link rel="stylesheet" href="<%= ctx %>/estilos.css">
    <link rel="stylesheet" href="<%= ctx %>/zonas/zonas.css">
</head>
<body>

    <main class="zonas-container">

        <jsp:include page="/header.jsp">
            <jsp:param name="modulo" value="zonas" />
            <jsp:param name="titulo" value="Zonas recreativas" />
            <jsp:param name="subtitulo" value="Gestión y consulta de espacios recreativos" />
        </jsp:include>

        <section class="zonas-introduccion">
            <h2>Consulta de zonas recreativas</h2>
            <p>Busque y consulte la información de los espacios recreativos disponibles en la universidad.</p>
        </section>

        <!-- Filtros: los aplica zonas.js en el navegador -->
        <section class="filtros-zonas">

            <div class="filtro-zona">
                <label for="buscarZona">Buscar zona</label>
                <input type="text" id="buscarZona" placeholder="Ejemplo: cancha">
            </div>

            <div class="filtro-zona">
                <label for="tipoZona">Tipo de zona</label>
                <select id="tipoZona">
                    <% for (String[] t : tipos) { %>
                    <option value="<%= t[0] %>"><%= t[1] %></option>
                    <% } %>
                </select>
            </div>

        </section>

        <section id="listaZonas" class="lista-zonas">
            <% for (String[] z : zonas) { %>
            <article class="zona"
                     data-nombre="<%= z[0] %>"
                     data-tipo="<%= z[1] %>">

                <div class="zona-icono"><%= z[6] %></div>

                <div class="zona-informacion">
                    <h3><%= z[0] %></h3>
                    <p><strong>Tipo:</strong> <%= z[2] %></p>
                    <p><strong>Ubicación:</strong> <%= z[3] %></p>
                    <p><strong>Capacidad:</strong> <%= z[4] %> personas</p>
                </div>

                <div class="estado-zona <%= z[5].equals("Disponible") ? "disponible-zona" : "ocupado-zona" %>">
                    <%= z[5] %>
                </div>

            </article>
            <% } %>
        </section>

        <p id="sinResultadosZonas" class="sin-resultados-zonas">
            No se encontraron zonas con los criterios seleccionados.
        </p>

    </main>

    <script src="<%= ctx %>/zonas/zonas.js"></script>

</body>
</html>
