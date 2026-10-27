<%@ page contentType="text/html;charset=UTF-8" pageEncoding="UTF-8" errorPage="error.jsp" %>
<%@ include file="/WEB-INF/sesion.jspf" %>
<%
    // request: lee el parametro "usuario" que llega por la URL (ejemplo: inicio.jsp?usuario=admin)
    String usuario = request.getParameter("usuario");

    if (usuario == null || usuario.isBlank()) {
        // Si no llega por URL, se usa el usuario de la sesion (viene de sesion.jspf)
        usuario = usuarioSesion;
    }
    usuario = usuario.trim();

    // Evita que lo escrito en la URL se interprete como HTML
    String usuarioSeguro = usuario.replace("&", "&amp;").replace("<", "&lt;")
                                  .replace(">", "&gt;").replace("\"", "&quot;");

    // response: agrega un encabezado HTTP (viaja en la respuesta, no se ve en pantalla)
    response.setHeader("X-Proyecto", "Gestion de Aulas ETITC");

    // application: primero se lee el usuario anterior y luego se guarda el actual.
    // Es memoria compartida por toda la aplicacion, por eso no se guardan datos privados.
    application.setAttribute("ultimoUsuario", usuarioSeguro);
%>
<!DOCTYPE html>
<html lang="es">

<head>

    <meta charset="UTF-8">

    <meta name="viewport" content="width=device-width, initial-scale=1.0">

    <title>Menu Principal | Gestion de Espacios</title>

    <link rel="stylesheet" href="estilos.css">

</head>


<body>

    <main class="inicio">


        <!-- Encabezado -->

        <header class="menu-header">

            <figure class="figura-logo">
                <img
                    src="img/logo-etitc.jpg"
                    alt="Logo ETITC"
                    class="logo-menu"
                >
                <figcaption>ETITC</figcaption>
            </figure>


            <div class="titulo-menu">

                <h1>
                    Gestión de Aulas y Espacios
                </h1>
            </div>

        </header>



        <section class="bienvenida">

            <h2>
                Bienvenido al sistema
            </h2>

            <%
                // out: escribe el saludo directamente en el HTML de respuesta
                out.println("<p>Hola, <strong>" + usuarioSeguro + "</strong></p>");
            %>

            <p>
                Seleccione una opción para continuar.
            </p>

            <p>Usuario activo en la sesión: <strong><%= usuarioSesion %></strong></p>

        </section>



        <!-- Opciones del menu -->

        <section class="opciones">


            <!-- Salones -->

            <a href="salones/salones.jsp" class="opcion">

                <div class="icono">🏫</div>
                <h3> Salones</h3>
                <p>
                    Consultar y gestionar los salones de la universidad.
                </p>

            </a>



            <!-- Zonas recreativas -->

            <a href="zonas/zonas.jsp" class="opcion">

                <div class="icono">⚽</div>
                <h3>Zonas recreativas</h3>
                <p>
                    Consultar los espacios recreativos disponibles.
                </p>

            </a>


            <!-- Reportes -->

            <a href="reportes/reportes.jsp" class="opcion">

                <div class="icono">📋</div>
                <h3>Reportes</h3>
                <p>
                    Registrar y consultar reportes sobre los espacios.
                </p>

            </a>


            <!-- Ayudas -->

            <a href="ayudas/ayudas.html" class="opcion">

                <div class="icono">❓</div>
                <h3>Ayudas</h3>
                <p>
                    Consultar información y ayuda sobre el sistema.
                </p>

            </a>


        </section>


        <!-- Cerrar sesion -->

        <form action="logout" method="post" style="margin:0;">
            <button type="submit" class="btn-cerrar">Cerrar sesión</button>
        </form>


    </main>

</body>

</html>
