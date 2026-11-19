package org.example;

import jakarta.servlet.ServletException;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

import java.io.IOException;
import java.sql.SQLException;

public class ConsultaSalonServlet extends HttpServlet {

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        // Sesion: sin usuario en la sesion se manda al login
        HttpSession sesion = request.getSession(false);
        if (sesion == null || sesion.getAttribute("usuario") == null) {
            response.sendRedirect(request.getContextPath() + "/login.jsp");
            return;
        }

        String nombre = request.getParameter("nombre");

        Salon salon = null;
        String mensaje = null;

        if (nombre == null || nombre.isBlank()) {
            mensaje = "Debe indicar el nombre del salón. Ejemplo: consulta-salon?nombre=A-101";
        } else {
            try {
                // DAO: busca el salon en la base de datos
                salon = new SalonDAO().buscarPorNombre(nombre.trim());

                if (salon == null) {
                    mensaje = "No existe un salón con ese nombre.";
                }
            } catch (SQLException e) {
                log("Error consultando el salón en la base de datos", e);
                mensaje = "No se pudo consultar la base de datos.";
            }
        }

        // El servlet solo prepara los datos; la JSP los muestra
        request.setAttribute("salon", salon);
        request.setAttribute("mensaje", mensaje);

        request.getRequestDispatcher("/WEB-INF/vistas/consulta-salon.jsp")
                .forward(request, response);
    }
}