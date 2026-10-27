package org.example;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.Cookie;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

import java.io.IOException;
import java.io.PrintWriter;
import java.net.URLEncoder;
import java.nio.charset.StandardCharsets;

@WebServlet(name = "LoginServlet", urlPatterns = "/login")
public class LoginServlet extends HttpServlet {

    private static final String USUARIO_VALIDO = "admin";
    private static final String PASSWORD_VALIDA = "12345";

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        String usuario = request.getParameter("usuario");
        String password = request.getParameter("password");

        if (usuario == null || usuario.trim().isEmpty()) {
            throw new UsuarioIncorrectoException("Debe ingresar el usuario.");
        }
        if (!usuario.trim().equals(USUARIO_VALIDO)) {
            throw new UsuarioIncorrectoException("El usuario ingresado no está registrado en el sistema.");
        }

        if (password == null || password.trim().isEmpty()) {
            throw new PasswordIncorrectaException("Debe ingresar la contraseña.");
        }
        if (!password.equals(PASSWORD_VALIDA)) {
            throw new PasswordIncorrectaException("La contraseña ingresada es incorrecta.");
        }

        request.getSession().setAttribute("usuario", USUARIO_VALIDO);

        Cookie cookie = new Cookie("ultimoUsuario", USUARIO_VALIDO);
        cookie.setMaxAge(60 * 60 * 24 * 7);   // 7 dias
        cookie.setHttpOnly(true);
        response.addCookie(cookie);

        String destino = "inicio.jsp?usuario="
                + URLEncoder.encode(USUARIO_VALIDO, StandardCharsets.UTF_8);

        response.setContentType("text/html;charset=UTF-8");
        PrintWriter out = response.getWriter();

        out.println("<html><head>");
        out.println("<meta charset='UTF-8'>");
        out.println("<link rel='stylesheet' href='estilos.css'>");
        out.println("<meta http-equiv='refresh' content='2;url=" + destino + "'>");
        out.println("</head><body>");
        out.println("<main class='login-container'>");
        out.println("<section class='login-box'>");
        out.println("<h1>Bienvenido, " + USUARIO_VALIDO + "</h1>");
        out.println("<p>Inicio de sesion correcto. Redirigiendo al menu principal...</p>");
        out.println("<p><a href='" + destino + "'>Continuar ahora</a></p>");
        out.println("</section>");
        out.println("</main>");
        out.println("</body></html>");
    }
}