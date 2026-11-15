<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<%-- Componente reutilizable: se incluye con <jsp:include page="/header.jsp"> --%>
<c:set var="ctx" value="${pageContext.request.contextPath}" />

<%-- Solo se aceptan estos modulos, para no usar texto arbitrario de la URL en las clases CSS --%>
<c:choose>
    <c:when test="${param.modulo eq 'zonas' or param.modulo eq 'reportes'}">
        <c:set var="modulo" value="${param.modulo}" />
    </c:when>
    <c:otherwise>
        <c:set var="modulo" value="salones" />
    </c:otherwise>
</c:choose>

<header class="${modulo}-header">
    <div class="${modulo}-titulo">
        <img src="${ctx}/img/logo-etitc.jpg" alt="Logo de la ETITC" class="logo-${modulo}">
        <div>
            <h1><c:out value="${param.titulo}" /></h1>
            <p><c:out value="${param.subtitulo}" /></p>
        </div>
    </div>
    <a href="${ctx}/inicio.jsp" class="btn-regresar">← <c:out value="${empty param.volver ? 'Volver al menú' : param.volver}" /></a>
</header>
