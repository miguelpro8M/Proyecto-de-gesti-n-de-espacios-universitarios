<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"
         import="java.util.List, java.util.ArrayList" %>

<%-- Comentario JSP: lo elimina Tomcat y NO llega al navegador --%>

<%!
    // Declaracion: variable y metodo que pasan a ser miembros del servlet generado
    private int contadorVisitas = 0;

    private String claseEstado(String estado) {
        return estado.equals("Disponible") ? "disponible" : "ocupado";
    }
%>

<%
    // Scriptlet: se ejecuta en cada solicitud
    contadorVisitas++;

    // Cada fila: nombre, edificio, piso, tipo, capacidad, estado
    List<String[]> salones = new ArrayList<>();
    salones.add(new String[]{"A-101", "A", "1", "Aula", "30", "Disponible"});
    salones.add(new String[]{"A-102", "A", "1", "Sala de computadores", "40", "Ocupado"});
    salones.add(new String[]{"A-201", "A", "2", "Aula", "35", "Disponible"});
    salones.add(new String[]{"B-101", "B", "1", "Laboratorio", "25", "Disponible"});
    salones.add(new String[]{"B-201", "B", "2", "Sala de computadores", "30", "Ocupado"});
    salones.add(new String[]{"C-301", "C", "3", "Auditorio", "100", "Disponible"});
    salones.add(new String[]{"C-302", "C", "3", "Laboratorio", "30", "Disponible"});
    salones.add(new String[]{"C-303", "C", "3", "Aula", "40", "Ocupado"});

    int disponibles = 0;
    for (String[] s : salones) {
        if (s[5].equals("Disponible")) {
            disponibles++;
        }
    }
%>
<!DOCTYPE html>
<html lang="es">
<head>
    <meta charset="UTF-8">
    <title>Listado de salones</title>
    <link rel="stylesheet" href="estilos.css">
    <style>
        .contenido { max-width: 1000px; margin: 30px auto; padding: 0 20px; }
        .contenido h1 { margin-bottom: 8px; }
        .resumen { margin-bottom: 20px; color: #555; }
        table { width: 100%; border-collapse: collapse; background: #fff;
                border-radius: 8px; overflow: hidden; box-shadow: 0 2px 8px rgba(0,0,0,0.08); }
        th { background: #2f3640; color: #fff; text-align: left; padding: 12px; }
        td { padding: 12px; border-bottom: 1px solid #e5e7eb; }
        .disponible { background-color: #d9f5df; color: #176b2c; font-weight: bold; }
        .ocupado { background-color: #f8d7da; color: #842029; font-weight: bold; }
    </style>
</head>
<body>

    <!-- Comentario HTML: SI llega al navegador (se ve con Ctrl+U) -->

    <jsp:include page="menu.jsp" />

    <main class="contenido">
        <h1>Listado de salones</h1>
        <p class="resumen">
            Salones disponibles: <strong><%= disponibles %></strong> de <%= salones.size() %>
            &nbsp;|&nbsp; Visitas a esta pagina: <%= contadorVisitas %>
        </p>

        <table>
            <tr>
                <th>Nombre</th>
                <th>Edificio</th>
                <th>Piso</th>
                <th>Tipo</th>
                <th>Capacidad</th>
                <th>Estado</th>
            </tr>
            <% for (String[] s : salones) { %>
            <tr>
                <td><%= s[0] %></td>
                <td><%= s[1] %></td>
                <td><%= s[2] %></td>
                <td><%= s[3] %></td>
                <td><%= s[4] %></td>
                <td class="<%= claseEstado(s[5]) %>"><%= s[5] %></td>
            </tr>
            <% } %>
        </table>
    </main>

</body>
</html>