<%@ page contentType="text/html;charset=UTF-8" pageEncoding="UTF-8" %>
<%!
// Evita que el valor de la cookie se interprete como HTML
private String esc(String texto) {
if (texto == null) {
return "";
}
return texto.replace("&", "&amp;").replace("<", "&lt;")
.replace(">", "&gt;").replace("\"", "&quot;");
}
%>
<%
// Cookie: si el navegador ya trae "ultimoUsuario", se usa para rellenar el campo
String ultimoUsuario = "";
Cookie[] cookies = request.getCookies();

if (cookies != null) {
for (Cookie c : cookies) {
if (c.getName().equals("ultimoUsuario")) {
ultimoUsuario = c.getValue();
}
}
}
%>

<!DOCTYPE html>
<html lang="es">

<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">

    <title>Inicio de Sesion | Gestion de Espacios</title>

    <link rel="stylesheet" href="estilos.css">
</head>

<body>

    <main class="login-container">

        <section class="login-box">

            <!-- Logo -->
            <figure class="figura-logo">
                <img 
                    src="img/logo-etitc.jpg" 
                    alt="Logo de la ETITC"
                    class="logo"
                >
                <figcaption>ETITC</figcaption>
            </figure>

            <!-- Titulo -->
            <h1>Gestion de Aulas y Espacios</h1>

            <p class="descripcion">
                Inicie sesion para acceder al sistema
            </p>


            <!-- Formulario -->
            <form id="loginForm" action="login" method="post">

                <!-- Usuario -->
                <div class="campo">

                    <label for="usuario">
                        Usuario
                    </label>

                    <input
                        type="text"
                        id="usuario"
                        name="usuario"
                        placeholder="Ingrese su usuario"
                        value="<%= esc(ultimoUsuario) %>"
                    >

                </div>


                <!-- Contraseña -->
                <div class="campo">

                    <label for="password">
                        Contraseña
                    </label>

                    <input
                        type="password"
                        id="password"
                        name="password"
                        placeholder="Ingrese su contraseña"
                    >

                </div>

                <!-- Boton -->
                <button type="submit" class="btn-login">
                    Iniciar sesión
                </button>

            </form>

        </section>

    </main>

</body>

</html>