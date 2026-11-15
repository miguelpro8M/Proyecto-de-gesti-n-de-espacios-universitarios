<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="x" uri="http://java.sun.com/jsp/jstl/xml" %>

<%-- Sesion: sin usuario activo se envia al login (c:redirect reemplaza al scriptlet) --%>
<c:if test="${empty sessionScope.usuario}">
    <c:redirect url="/login.jsp" />
</c:if>

<c:set var="idiomaActual" value="${empty sessionScope.idioma ? 'es' : sessionScope.idioma}" />
<fmt:setLocale value="${idiomaActual eq 'en' ? 'en_US' : 'es_CO'}" />
<fmt:setBundle basename="mensajes" />

<c:set var="ctx" value="${pageContext.request.contextPath}" />
<c:url var="urlVolver" value="/reportes" />

<%-- x:parse convierte el texto XML en un documento ($doc) que x:out y x:forEach pueden consultar --%>
<x:parse var="doc">
    <edificios>
        <edificio nombre="A">
            <salon><nombre>A-101</nombre><tipo>Aula</tipo><capacidad>30</capacidad></salon>
            <salon><nombre>A-102</nombre><tipo>Sala de computadores</tipo><capacidad>40</capacidad></salon>
            <salon><nombre>A-201</nombre><tipo>Aula</tipo><capacidad>35</capacidad></salon>
        </edificio>
        <edificio nombre="B">
            <salon><nombre>B-101</nombre><tipo>Laboratorio</tipo><capacidad>25</capacidad></salon>
            <salon><nombre>B-201</nombre><tipo>Sala de computadores</tipo><capacidad>30</capacidad></salon>
        </edificio>
        <edificio nombre="C">
            <salon><nombre>C-301</nombre><tipo>Auditorio</tipo><capacidad>100</capacidad></salon>
            <salon><nombre>C-302</nombre><tipo>Laboratorio</tipo><capacidad>30</capacidad></salon>
            <salon><nombre>C-303</nombre><tipo>Aula</tipo><capacidad>40</capacidad></salon>
        </edificio>
    </edificios>
</x:parse>

<!DOCTYPE html>
<html lang="${idiomaActual}">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title><fmt:message key="xml.titulo" /> | Gestión de Espacios</title>
    <link rel="stylesheet" href="${ctx}/estilos.css">
    <style>
        .xml-contenedor { max-width: 800px; margin: 30px auto; padding: 24px; background: #fff;
                          border-radius: 12px; box-shadow: 0 2px 8px rgba(0,0,0,0.08); }
        .xml-contenedor h1 { margin-bottom: 10px; }
        .xml-contenedor h2 { margin: 22px 0 8px 0; }
        .xml-contenedor table { width: 100%; border-collapse: collapse; margin-top: 8px; }
        .xml-contenedor th { background: #2f3640; color: #fff; text-align: left; padding: 10px; }
        .xml-contenedor td { padding: 10px; border-bottom: 1px solid #e5e7eb; }
    </style>
</head>
<body>

    <main class="xml-contenedor">

        <h1><fmt:message key="xml.titulo" /></h1>
        <p><fmt:message key="xml.descripcion" /></p>

        <%-- x:out con rutas XPath: busca un dato concreto dentro del documento --%>
        <h2><fmt:message key="xml.primero" /></h2>
        <p>
            <fmt:message key="xml.edificio" />:
            <strong><x:out select="$doc/edificios/edificio[1]/@nombre" /></strong>
            &nbsp;|&nbsp;
            <fmt:message key="xml.salon" />:
            <strong><x:out select="$doc/edificios/edificio[1]/salon[1]/nombre" /></strong>
            &nbsp;|&nbsp;
            <fmt:message key="xml.tipo" />:
            <x:out select="$doc/edificios/edificio[1]/salon[1]/tipo" />
        </p>

        <%-- x:forEach + x:out: recorre todos los salones del XML --%>
        <h2><fmt:message key="xml.todos" /></h2>
        <table>
            <tr>
                <th><fmt:message key="xml.edificio" /></th>
                <th><fmt:message key="xml.salon" /></th>
                <th><fmt:message key="xml.tipo" /></th>
                <th><fmt:message key="xml.capacidad" /></th>
            </tr>
            <x:forEach select="$doc/edificios/edificio/salon">
                <tr>
                    <td><x:out select="../@nombre" /></td>
                    <td><x:out select="nombre" /></td>
                    <td><x:out select="tipo" /></td>
                    <td><x:out select="capacidad" /></td>
                </tr>
            </x:forEach>
        </table>

        <p style="margin-top:20px;"><a href="${urlVolver}">← <fmt:message key="xml.volver" /></a></p>

    </main>

</body>
</html>