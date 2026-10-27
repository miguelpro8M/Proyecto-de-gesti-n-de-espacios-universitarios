package org.example;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

public class SalonDAO {

    private static final String COLUMNAS =
            "nombre, edificio, piso, tipo, tipo_nombre, capacidad, estado";

    public List<Salon> listar() throws SQLException {
        List<Salon> salones = new ArrayList<>();
        String sql = "SELECT " + COLUMNAS + " FROM salones ORDER BY nombre";

        try (Connection cn = Conexion.obtener();
             PreparedStatement ps = cn.prepareStatement(sql);
             ResultSet rs = ps.executeQuery()) {

            while (rs.next()) {
                salones.add(crearSalon(rs));
            }
        }
        return salones;
    }

    public Salon buscarPorNombre(String nombre) throws SQLException {
        String sql = "SELECT " + COLUMNAS + " FROM salones WHERE nombre = ?";

        try (Connection cn = Conexion.obtener();
             PreparedStatement ps = cn.prepareStatement(sql)) {

            ps.setString(1, nombre);

            try (ResultSet rs = ps.executeQuery()) {
                if (rs.next()) {
                    return crearSalon(rs);
                }
            }
        }
        return null;
    }

    // Reservar / liberar: alterna entre Disponible y Ocupado
    public void cambiarEstado(String nombre) throws SQLException {
        String sql = "UPDATE salones "
                + "SET estado = CASE WHEN estado = 'Disponible' THEN 'Ocupado' ELSE 'Disponible' END "
                + "WHERE nombre = ?";

        try (Connection cn = Conexion.obtener();
             PreparedStatement ps = cn.prepareStatement(sql)) {

            ps.setString(1, nombre);
            ps.executeUpdate();
        }
    }

    // Convierte la fila actual del ResultSet en un objeto Salon
    private Salon crearSalon(ResultSet rs) throws SQLException {
        return new Salon(
                rs.getString("nombre"),
                rs.getString("edificio"),
                rs.getInt("piso"),
                rs.getString("tipo"),
                rs.getString("tipo_nombre"),
                rs.getInt("capacidad"),
                rs.getString("estado")
        );
    }
}
