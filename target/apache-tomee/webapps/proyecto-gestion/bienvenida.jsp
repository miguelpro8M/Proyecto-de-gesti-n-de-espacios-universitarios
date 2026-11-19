<%@ page contentType="text/html;charset=UTF-8" language="java" %>

<!DOCTYPE html>
<html lang="es">
<head>
    <meta charset="UTF-8">
    <title>Bienvenido</title>

    <link rel="stylesheet" href="estilos.css">

    <!-- Redirigir al menú después de 2 segundos -->
    <meta http-equiv="refresh" content="2;url=inicio.jsp">
</head>

<body>

    <main class="login-container">
        <section class="login-box">

            <h1>Bienvenido, ${sessionScope.usuario}</h1>

            <p>Inicio de sesión correcto.</p>
            <p>Redirigiendo al menú principal...</p>

            <p>
                <a href="inicio.jsp">Continuar ahora</a>
            </p>

        </section>
    </main>

</body>
</html>
