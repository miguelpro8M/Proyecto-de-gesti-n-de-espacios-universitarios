package org.example;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.SQLException;

public class Conexion {

    private static final String URL =
            "jdbc:mysql://localhost:3306/gestion_espacios"
                    + "?useSSL=false&allowPublicKeyRetrieval=true&serverTimezone=America/Bogota";
    private static final String USUARIO = "gestion_user";
    private static final String CLAVE = "gestion123";

    public static Connection obtener() throws SQLException {
        try {
            Class.forName("com.mysql.cj.jdbc.Driver");
        } catch (ClassNotFoundException e) {
            throw new SQLException("No se encontró el driver de MySQL (revise el pom.xml).", e);
        }
        return DriverManager.getConnection(URL, USUARIO, CLAVE);
    }
}
