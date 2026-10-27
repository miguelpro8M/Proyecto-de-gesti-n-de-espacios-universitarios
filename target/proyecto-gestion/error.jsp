<%@ page contentType="text/html;charset=UTF-8" pageEncoding="UTF-8"
         isErrorPage="true"
         import="org.example.UsuarioIncorrectoException, org.example.PasswordIncorrectaException, java.sql.SQLException" %>

<%!
    // Evita que el texto del error se interprete como HTML
    private String esc(String texto) {
        if (texto == null) {
            return "";
        }
        return texto.replace("&", "&amp;").replace("<", "&lt;")
                    .replace(">", "&gt;").replace("\"", "&quot;");
    }
%>
<%
    String ctx = request.getContextPath();

    // El condicional evita fallar si exception llega nulo (por ejemplo, si abren error.jsp directo)
    String mensaje = (exception != null && exception.getMessage() != null)
            ? exception.getMessage()
            : "Error no identificado";

    // Por defecto (cualquier otro error del sistema)
    String titulo = "Ocurrió un error";
    String volver = ctx + "/inicio.jsp";
    String textoVolver = "Volver al menú";

    // exception: se revisa que tipo de error llego a esta pagina
    if (exception instanceof UsuarioIncorrectoException) {
        titulo = "Error en el usuario";
        volver = ctx + "/login.jsp";
        textoVolver = "Volver a intentar";
    } else if (exception instanceof PasswordIncorrectaException) {
        titulo = "Error en la contraseña";
        volver = ctx + "/login.jsp";
        textoVolver = "Volver a intentar";
    } else if (exception instanceof SQLException) {
        titulo = "Error de base de datos";
        mensaje = "No se pudo conectar o consultar la base de datos. "
                + "Verifique que MySQL/MariaDB esté activo.";

        // Deja el detalle tecnico en el log de Tomcat para poder revisarlo
        application.log("Error de base de datos", exception);
    }
%>
<!DOCTYPE html>
<html lang="es">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title><%= titulo %> | Gestión de Espacios</title>
    <link rel="stylesheet" href="<%= ctx %>/estilos.css">
</head>
<body>

    <main class="login-container">
        <section class="login-box">

            <h1><%= titulo %></h1>

            <p><%= esc(mensaje) %></p>

            <p><a href="<%= volver %>"><%= textoVolver %></a></p>

        </section>
    </main>

</body>
</html>