package org.example;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

import java.io.IOException;
import java.io.PrintWriter;

@WebServlet(name = "LoginServlet", urlPatterns = "/login")
public class LoginServlet extends HttpServlet {

    private static final String USUARIO_VALIDO = "admin";
    private static final String PASSWORD_VALIDA = "12345";

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        response.setContentType("text/html;charset=UTF-8");
        PrintWriter out = response.getWriter();

        String usuario = request.getParameter("usuario");
        String password = request.getParameter("password");

        // Validacion de campos obligatorios
        if (usuario == null || usuario.trim().isEmpty()
                || password == null || password.trim().isEmpty()) {
            mostrarError(out, "Debe ingresar usuario y contrasena.");
            return;
        }

        // Validacion de credenciales
        if (usuario.equals(USUARIO_VALIDO) && password.equals(PASSWORD_VALIDA)) {
            out.println("<html><head>");
            out.println("<meta charset='UTF-8'>");
            out.println("<link rel='stylesheet' href='estilos.css'>");
            out.println("<meta http-equiv='refresh' content='2;url=inicio.html'>");
            out.println("</head><body>");
            out.println("<main class='login-container'>");
            out.println("<section class='login-box'>");
            out.println("<h1>Bienvenido, " + usuario + "</h1>");
            out.println("<p>Inicio de sesion correcto. Redirigiendo al menu principal...</p>");
            out.println("<p><a href='inicio.html'>Continuar ahora</a></p>");
            out.println("</section>");
            out.println("</main>");
            out.println("</body></html>");
        } else {
            mostrarError(out, "Usuario o contrasena incorrectos.");
        }
    }

    private void mostrarError(PrintWriter out, String mensaje) {
        out.println("<html><head>");
        out.println("<meta charset='UTF-8'>");
        out.println("<link rel='stylesheet' href='estilos.css'>");
        out.println("</head><body>");
        out.println("<main class='login-container'>");
        out.println("<section class='login-box'>");
        out.println("<h1>Error de inicio de sesion</h1>");
        out.println("<p>" + mensaje + "</p>");
        out.println("<p><a href='index.html'>Volver a intentar</a></p>");
        out.println("</section>");
        out.println("</main>");
        out.println("</body></html>");
    }
}