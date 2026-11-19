<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<c:set var="ctx" value="${pageContext.request.contextPath}" />
<!DOCTYPE html>
<html lang="es">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Consulta de salón</title>
    <link rel="stylesheet" href="${ctx}/estilos.css">
</head>
<body>

    <main class="login-container">
        <section class="login-box">

            <c:choose>

                <%-- El servlet encontro el salon --%>
                <c:when test="${not empty salon}">
                    <h1>Salón <c:out value="${salon.nombre}" /></h1>
                    <p>Edificio: <c:out value="${salon.edificio}" /></p>
                    <p>Piso: <c:out value="${salon.piso}" /></p>
                    <p>Tipo: <c:out value="${salon.tipoNombre}" /></p>
                    <p>Capacidad: <c:out value="${salon.capacidad}" /> personas</p>
                    <p>Estado: <c:out value="${salon.estado}" /></p>
                </c:when>

                <%-- No hay salon: se muestra el mensaje que preparo el servlet --%>
                <c:otherwise>
                    <h1>Consulta de salón</h1>
                    <p><c:out value="${mensaje}" /></p>
                </c:otherwise>

            </c:choose>

            <p><a href="${ctx}/salones/salones.jsp">Volver a salones</a></p>

        </section>
    </main>

</body>
</html>