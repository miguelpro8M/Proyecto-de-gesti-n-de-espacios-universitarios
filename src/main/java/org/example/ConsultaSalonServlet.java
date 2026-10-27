package org.example;

import jakarta.servlet.ServletException;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

import java.io.IOException;
import java.io.PrintWriter;
import java.sql.SQLException;

// Registrado en web.xml con la ruta /consulta-salon (Semana 7)
public class ConsultaSalonServlet extends HttpServlet {

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        String ctx = request.getContextPath();

        // Sesion: sin usuario en la sesion se manda al login
        HttpSession sesion = request.getSession(false);
        if (sesion == null || sesion.getAttribute("usuario") == null) {
            response.sendRedirect(ctx + "/login.jsp");
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

        response.setContentType("text/html;charset=UTF-8");
        PrintWriter out = response.getWriter();

        out.println("<!DOCTYPE html>");
        out.println("<html lang='es'><head>");
        out.println("<meta charset='UTF-8'>");
        out.println("<title>Consulta de salón</title>");
        out.println("<link rel='stylesheet' href='" + ctx + "/estilos.css'>");
        out.println("</head><body>");
        out.println("<main class='login-container'>");
        out.println("<section class='login-box'>");

        if (salon == null) {
            out.println("<h1>Consulta de salón</h1>");
            out.println("<p>" + mensaje + "</p>");
        } else {
            out.println("<h1>Salón " + salon.getNombre() + "</h1>");
            out.println("<p>Edificio: " + salon.getEdificio() + "</p>");
            out.println("<p>Piso: " + salon.getPiso() + "</p>");
            out.println("<p>Tipo: " + salon.getTipoNombre() + "</p>");
            out.println("<p>Capacidad: " + salon.getCapacidad() + " personas</p>");
            out.println("<p>Estado: " + salon.getEstado() + "</p>");
        }

        out.println("<p><a href='" + ctx + "/salones/salones.jsp'>Volver a salones</a></p>");
        out.println("</section>");
        out.println("</main>");
        out.println("</body></html>");
    }
}