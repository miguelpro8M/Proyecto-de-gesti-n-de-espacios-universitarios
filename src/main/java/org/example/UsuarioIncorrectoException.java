package org.example;

import jakarta.servlet.ServletException;

public class UsuarioIncorrectoException extends ServletException {

    public UsuarioIncorrectoException(String mensaje) {
        super(mensaje);
    }
}
