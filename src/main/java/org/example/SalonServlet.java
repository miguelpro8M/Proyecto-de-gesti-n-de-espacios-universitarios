package org.example;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

import java.io.IOException;
import java.net.URLEncoder;
import java.nio.charset.StandardCharsets;
import java.sql.SQLException;

@WebServlet(name = "SalonServlet", urlPatterns = "/cambiar-estado")
public class SalonServlet extends HttpServlet {

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        request.setCharacterEncoding("UTF-8");

        // Sesion: sin usuario en la sesion no se puede cambiar nada
        HttpSession sesion = request.getSession(false);
        if (sesion == null || sesion.getAttribute("usuario") == null) {
            response.sendRedirect(request.getContextPath() + "/login.jsp");
            return;
        }

        String nombre = request.getParameter("nombre");
        String buscar = request.getParameter("buscar");
        String edificio = request.getParameter("edificio");
        String tipo = request.getParameter("tipo");

        if (nombre != null && !nombre.isBlank()) {
            try {
                new SalonDAO().cambiarEstado(nombre);
            } catch (SQLException e) {
                throw new ServletException("No se pudo actualizar el estado del salón.", e);
            }
        }

        String url = request.getContextPath() + "/salones/salones.jsp"
                + "?buscar=" + codificar(buscar)
                + "&edificio=" + codificar(edificio)
                + "&tipo=" + codificar(tipo);

        response.sendRedirect(url);
    }

    private String codificar(String valor) {
        return URLEncoder.encode(valor == null ? "" : valor, StandardCharsets.UTF_8);
    }
}