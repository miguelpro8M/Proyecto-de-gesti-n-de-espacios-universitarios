<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>

<%-- ===== Idioma: ?idioma=es o ?idioma=en. Se guarda en la sesion para no perderlo al enviar el formulario ===== --%>
<c:if test="${param.idioma eq 'es' or param.idioma eq 'en'}">
    <c:set var="idioma" value="${param.idioma}" scope="session" />
</c:if>
<c:set var="idiomaActual" value="${empty sessionScope.idioma ? 'es' : sessionScope.idioma}" />

<fmt:setLocale value="${idiomaActual eq 'en' ? 'en_US' : 'es_CO'}" />
<fmt:setBundle basename="mensajes" />

<c:set var="ctx" value="${pageContext.request.contextPath}" />

<%-- ===== Textos que se reutilizan (fmt:message guarda el resultado en una variable) ===== --%>
<fmt:message key="reportes.titulo" var="txtTitulo" />
<fmt:message key="reportes.subtitulo" var="txtSubtitulo" />
<fmt:message key="reportes.volver" var="txtVolver" />
<fmt:message key="form.seleccione" var="txtSeleccione" />
<fmt:message key="form.espacio.primero" var="txtPrimero" />
<fmt:message key="form.espacio.elegir" var="txtElegir" />
<fmt:message key="form.descripcion.ayuda" var="txtAyuda" />

<%-- ===== c:set + c:choose: el codigo ?error=... se convierte en un mensaje ===== --%>
<c:set var="mensajeError" value="" />
<c:choose>
    <c:when test="${param.error eq 'campos'}">
        <fmt:message key="reportes.error.campos" var="mensajeError" />
    </c:when>
    <c:when test="${param.error eq 'invalido'}">
        <fmt:message key="reportes.error.invalido" var="mensajeError" />
    </c:when>
    <c:when test="${param.error eq 'largo'}">
        <fmt:message key="reportes.error.largo" var="mensajeError" />
    </c:when>
</c:choose>

<%-- ===== c:url + c:param: enlaces que respetan el contexto de la aplicacion ===== --%>
<c:url var="urlEs" value="/reportes">
    <c:param name="idioma" value="es" />
    <c:if test="${not empty param.prioridad}">
        <c:param name="prioridad" value="${param.prioridad}" />
    </c:if>
</c:url>
<c:url var="urlEn" value="/reportes">
    <c:param name="idioma" value="en" />
    <c:if test="${not empty param.prioridad}">
        <c:param name="prioridad" value="${param.prioridad}" />
    </c:if>
</c:url>
<c:url var="urlTodas" value="/reportes" />
<c:url var="urlXml" value="/xml-demo.jsp" />

<!DOCTYPE html>
<html lang="${idiomaActual}">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title><c:out value="${txtTitulo}" /> | Gestión de Espacios</title>
    <link rel="stylesheet" href="${ctx}/estilos.css">
    <link rel="stylesheet" href="${ctx}/reportes/reportes.css">
    <style>
        .mensaje-exito, .mensaje-error {
            padding: 12px 16px;
            border-radius: 8px;
            margin-bottom: 16px;
            font-weight: bold;
        }
        .mensaje-exito { background-color: #d9f5df; color: #176b2c; }
        .mensaje-error { background-color: #f8d7da; color: #842029; }
        .barra-info { margin: 0 0 18px 0; color: #555; line-height: 1.8; }
        .demo-jstl { margin-top: 30px; padding: 14px 18px; background: #fff; border-radius: 8px; color: #555; }
    </style>
</head>
<body>

    <main class="reportes-container">

        <jsp:include page="/header.jsp">
            <jsp:param name="modulo" value="reportes" />
            <jsp:param name="titulo" value="${txtTitulo}" />
            <jsp:param name="subtitulo" value="${txtSubtitulo}" />
            <jsp:param name="volver" value="${txtVolver}" />
        </jsp:include>

        <%-- ===== fmt: idioma, fecha formateada y usuario de la sesion ===== --%>
        <p class="barra-info">
            <fmt:message key="reportes.idioma" />:
            <a href="${urlEs}">Español</a> | <a href="${urlEn}">English</a>
            &nbsp;|&nbsp;
            <fmt:message key="reportes.fecha" />:
            <fmt:formatDate value="${fechaActual}" pattern="dd/MM/yyyy" />
            &nbsp;|&nbsp;
            <fmt:message key="reportes.usuario" />:
            <c:out value="${sessionScope.usuario}" default="-" />
            &nbsp;|&nbsp;
            <a href="${urlXml}"><fmt:message key="xml.enlace" /></a>
        </p>

        <section class="reportes-introduccion">
            <h2><fmt:message key="reportes.intro.titulo" /></h2>
            <p><fmt:message key="reportes.intro.texto" /></p>
        </section>

        <section class="formulario-reporte">

            <%-- c:if: mensaje de exito (el servlet entrega numeroRegistrado) --%>
            <c:if test="${not empty numeroRegistrado}">
                <p class="mensaje-exito">
                    <fmt:message key="reportes.exito" /> <c:out value="${numeroRegistrado}" />
                </p>
            </c:if>

            <c:if test="${not empty mensajeError}">
                <p class="mensaje-error"><c:out value="${mensajeError}" /></p>
            </c:if>

            <%-- c:remove: la variable ya se mostro, se elimina --%>
            <c:remove var="mensajeError" />

            <!-- El formulario se envia por POST a ReporteServlet -->
            <form id="formularioReporte" method="post" action="${ctx}/reportes">

                <div class="campo-reporte">
                    <label for="tipoEspacio"><fmt:message key="form.tipoEspacio" /></label>
                    <select id="tipoEspacio" name="tipoEspacio" required>
                        <option value=""><c:out value="${txtSeleccione}" /></option>
                        <option value="Salón"><fmt:message key="espacio.salon" /></option>
                        <option value="Zona recreativa"><fmt:message key="espacio.zona" /></option>
                    </select>
                </div>

                <!-- Las opciones las llena reportes.js a partir de estos data- -->
                <div class="campo-reporte">
                    <label for="espacio"><fmt:message key="form.espacio" /></label>
                    <select id="espacio" name="espacio" required disabled
                            data-salones="<c:out value='${espaciosSalones}' />"
                            data-zonas="<c:out value='${espaciosZonas}' />"
                            data-texto-primero="<c:out value='${txtPrimero}' />"
                            data-texto-elegir="<c:out value='${txtElegir}' />">
                        <option value=""><c:out value="${txtPrimero}" /></option>
                    </select>
                </div>

                <div class="campo-reporte">
                    <label for="tipoReporte"><fmt:message key="form.tipoReporte" /></label>
                    <select id="tipoReporte" name="tipoReporte" required>
                        <option value=""><c:out value="${txtSeleccione}" /></option>
                        <option value="Daño o avería"><fmt:message key="tipo.dano" /></option>
                        <option value="Limpieza"><fmt:message key="tipo.limpieza" /></option>
                        <option value="Problema con equipos"><fmt:message key="tipo.equipos" /></option>
                        <option value="Problema con mobiliario"><fmt:message key="tipo.mobiliario" /></option>
                        <option value="Otro"><fmt:message key="tipo.otro" /></option>
                    </select>
                </div>

                <div class="campo-reporte">
                    <label for="prioridad"><fmt:message key="form.prioridad" /></label>
                    <select id="prioridad" name="prioridad" required>
                        <option value=""><c:out value="${txtSeleccione}" /></option>
                        <option value="Baja"><fmt:message key="prioridad.Baja" /></option>
                        <option value="Media"><fmt:message key="prioridad.Media" /></option>
                        <option value="Alta"><fmt:message key="prioridad.Alta" /></option>
                    </select>
                </div>

                <div class="campo-reporte campo-completo">
                    <label for="descripcion"><fmt:message key="form.descripcion" /></label>
                    <textarea id="descripcion" name="descripcion" rows="6" maxlength="500" required
                              placeholder="<c:out value='${txtAyuda}' />"></textarea>
                </div>

                <div class="botones-reporte">
                    <button type="reset" class="btn-cancelar"><fmt:message key="form.limpiar" /></button>
                    <button type="submit" class="btn-enviar"><fmt:message key="form.enviar" /></button>
                </div>

            </form>
        </section>

        <section class="reportes-recientes">

            <h2><fmt:message key="lista.titulo" /></h2>

            <%-- fmt:formatNumber: numero y porcentaje (el servlet entrega total y porcentajeAlta) --%>
            <p class="barra-info">
                <fmt:message key="lista.total" />: <fmt:formatNumber value="${total}" />
                &nbsp;|&nbsp;
                <fmt:message key="lista.porcentajeAlta" />:
                <fmt:formatNumber value="${porcentajeAlta}" type="percent" maxFractionDigits="1" />
            </p>

            <%-- EL (param) + c:url + c:param + c:forEach + c:choose: filtro por prioridad --%>
            <p class="barra-info">
                <fmt:message key="lista.filtro" />:
                <c:choose>
                    <c:when test="${empty param.prioridad}">
                        <strong><fmt:message key="lista.todas" /></strong>
                    </c:when>
                    <c:otherwise>
                        <a href="${urlTodas}"><fmt:message key="lista.todas" /></a>
                    </c:otherwise>
                </c:choose>

                <c:forEach var="p" items="${prioridades}">
                    |
                    <c:url var="urlFiltro" value="/reportes">
                        <c:param name="prioridad" value="${p}" />
                    </c:url>
                    <c:choose>
                        <c:when test="${param.prioridad eq p}">
                            <strong><fmt:message key="prioridad.${p}" /></strong>
                        </c:when>
                        <c:otherwise>
                            <a href="${urlFiltro}"><fmt:message key="prioridad.${p}" /></a>
                        </c:otherwise>
                    </c:choose>
                </c:forEach>

                <br>
                <fmt:message key="lista.paramRecibido" />:
                <fmt:message key="lista.ninguno" var="txtNinguno" />
                <c:out value="${param.prioridad}" default="${txtNinguno}" />
            </p>

            <div id="listaReportes">

                <%-- c:if: lista vacia --%>
                <c:if test="${empty reportes}">
                    <p class="sin-reportes"><fmt:message key="lista.vacia" /></p>
                </c:if>

                <%-- c:forEach: una tarjeta por cada reporte que preparo el servlet --%>
                <c:forEach var="r" items="${reportes}">
                    <article class="tarjeta-reporte">

                        <div class="reporte-cabecera">
                            <h3><c:out value="${r.numero}" /></h3>
                            <span class="estado-reporte"><fmt:message key="estado.${r.estado}" /></span>
                        </div>

                        <p><strong><fmt:message key="lista.informacion" />:</strong>
                           <c:out value="${r.mostrarInformacion()}" /></p>
                        <p><strong><fmt:message key="lista.tipo" />:</strong>
                           <c:out value="${r.tipoReporte}" /></p>

                        <%-- c:choose: la clase CSS depende de la prioridad --%>
                        <p>
                            <strong><fmt:message key="form.prioridad" />:</strong>
                            <c:choose>
                                <c:when test="${r.prioridad eq 'Alta'}">
                                    <span class="prioridad-alta"><fmt:message key="prioridad.Alta" /></span>
                                </c:when>
                                <c:when test="${r.prioridad eq 'Media'}">
                                    <span class="prioridad-media"><fmt:message key="prioridad.Media" /></span>
                                </c:when>
                                <c:otherwise>
                                    <span class="prioridad-baja"><fmt:message key="prioridad.Baja" /></span>
                                </c:otherwise>
                            </c:choose>
                        </p>

                        <p><strong><fmt:message key="lista.descripcion" />:</strong>
                           <c:out value="${r.descripcion}" /></p>

                        <%-- fmt:formatDate: fecha y hora segun el idioma elegido --%>
                        <p class="fecha-reporte">
                            <fmt:message key="lista.registrado" />
                            <fmt:formatDate value="${r.fechaDate}" type="both" dateStyle="medium" timeStyle="short" />
                        </p>

                    </article>
                </c:forEach>

            </div>

        </section>

        <%-- Demostracion visible de c:set y c:remove --%>
        <section class="demo-jstl">
            <strong><fmt:message key="demo.titulo" /></strong><br>
            <c:set var="aviso" value="JSTL" />
            <fmt:message key="demo.antes" />:
            <c:out value="${aviso}" default="-" /><br>
            <c:remove var="aviso" />
            <fmt:message key="demo.despues" />:
            <fmt:message key="demo.eliminada" var="txtEliminada" />
            <c:out value="${aviso}" default="${txtEliminada}" />
        </section>

    </main>

    <script src="${ctx}/reportes/reportes.js"></script>

</body>
</html>