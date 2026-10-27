<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%
    // Componente reutilizable: se incluye con <jsp:include page="/header.jsp">
    String ctx = request.getContextPath();
    String modulo = request.getParameter("modulo");
    String titulo = request.getParameter("titulo");
    String subtitulo = request.getParameter("subtitulo");

    // Solo se aceptan estos valores, para no usar texto arbitrario de la URL en las clases CSS
    if (!"zonas".equals(modulo) && !"reportes".equals(modulo)) {
        modulo = "salones";
    }
    if (titulo == null) {
        titulo = "";
    }
    if (subtitulo == null) {
        subtitulo = "";
    }
%>
<header class="<%= modulo %>-header">
    <div class="<%= modulo %>-titulo">
        <img src="<%= ctx %>/img/logo-etitc.jpg" alt="Logo de la ETITC" class="logo-<%= modulo %>">
        <div>
            <h1><%= titulo %></h1>
            <p><%= subtitulo %></p>
        </div>
    </div>
    <a href="<%= ctx %>/inicio.jsp" class="btn-regresar">← Volver al menú</a>
</header>
