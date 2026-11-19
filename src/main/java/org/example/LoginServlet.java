package org.example;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.Cookie;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

import java.io.IOException;

@WebServlet(name = "LoginServlet", urlPatterns = "/login")
public class LoginServlet extends HttpServlet {

    private static final String USUARIO_VALIDO = "admin";
    private static final String PASSWORD_VALIDA = "12345";

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        String usuario = request.getParameter("usuario");
        String password = request.getParameter("password");

        // error 1
        if (usuario == null || usuario.trim().isEmpty()) {
            throw new UsuarioIncorrectoException("Debe ingresar el usuario.");
        }
        if (!usuario.trim().equals(USUARIO_VALIDO)) {
            throw new UsuarioIncorrectoException("El usuario ingresado no está registrado en el sistema.");
        }
        // error 2
        if (password == null || password.trim().isEmpty()) {
            throw new PasswordIncorrectaException("Debe ingresar la contraseña.");
        }
        if (!password.equals(PASSWORD_VALIDA)) {
            throw new PasswordIncorrectaException("La contraseña ingresada es incorrecta.");
        }

        request.getSession().setAttribute("usuario", USUARIO_VALIDO);

        // Cookie: recuerda el ultimo usuario
        Cookie cookie = new Cookie("ultimoUsuario", USUARIO_VALIDO);
        cookie.setMaxAge(60 * 60 * 24 * 7);
        cookie.setHttpOnly(true);
        response.addCookie(cookie);

        response.sendRedirect(request.getContextPath() + "/bienvenida.jsp");
    }
}
