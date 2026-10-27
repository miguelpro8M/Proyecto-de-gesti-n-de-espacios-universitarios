package org.example;

import jakarta.servlet.ServletException;

public class PasswordIncorrectaException extends ServletException {

    public PasswordIncorrectaException(String mensaje) {
        super(mensaje);
    }
}
