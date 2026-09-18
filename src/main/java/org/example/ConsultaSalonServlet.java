package org.example;

import jakarta.servlet.ServletException;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

import java.io.IOException;
import java.io.PrintWriter;

public class ConsultaSalonServlet extends HttpServlet {

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        response.setContentType("text/html;charset=UTF-8");
        PrintWriter out = response.getWriter();

        String nombre = request.getParameter("nombre");
        if (nombre == null || nombre.isEmpty()) {
            nombre = "Salon 101";
        }

        out.println("<html><head><title>Consulta de Salon</title></head><body>");
        out.println("<h2>Consulta desde el servidor</h2>");
        out.println("<p>Salon: " + nombre + "</p>");
        out.println("<p>Edificio: A</p>");
        out.println("<p>Tipo: Aula</p>");
        out.println("<p>Estado: Disponible</p>");
        out.println("<p><a href='/'>Volver al inicio</a></p>");
        out.println("</body></html>");
    }
}