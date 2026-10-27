package org.example;

public class Salon {

    private final String nombre;
    private final String edificio;
    private final int piso;
    private final String tipo;
    private final String tipoNombre;  // texto que ve el usuario
    private final int capacidad;
    private final String estado;      // "Disponible" u "Ocupado"

    public Salon(String nombre, String edificio, int piso, String tipo,
                 String tipoNombre, int capacidad, String estado) {
        this.nombre = nombre;
        this.edificio = edificio;
        this.piso = piso;
        this.tipo = tipo;
        this.tipoNombre = tipoNombre;
        this.capacidad = capacidad;
        this.estado = estado;
    }

    public String getNombre() { return nombre; }
    public String getEdificio() { return edificio; }
    public int getPiso() { return piso; }
    public String getTipo() { return tipo; }
    public String getTipoNombre() { return tipoNombre; }
    public int getCapacidad() { return capacidad; }
    public String getEstado() { return estado; }

    public boolean isDisponible() {
        return "Disponible".equals(estado);
    }
}