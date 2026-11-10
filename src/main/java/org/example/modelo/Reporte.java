package org.example.modelo;

import jakarta.persistence.Column;
import jakarta.persistence.Entity;
import jakarta.persistence.GeneratedValue;
import jakarta.persistence.GenerationType;
import jakarta.persistence.Id;
import jakarta.persistence.Table;

import java.time.LocalDateTime;
import java.time.format.DateTimeFormatter;

// Entidad JPA: cada objeto Reporte es una fila de la tabla "reportes"
@Entity
@Table(name = "reportes")
public class Reporte {

    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private Long id;

    @Column(name = "tipo_espacio", nullable = false, length = 30)
    private String tipoEspacio;

    @Column(nullable = false, length = 50)
    private String espacio;

    @Column(name = "tipo_reporte", nullable = false, length = 40)
    private String tipoReporte;

    @Column(nullable = false, length = 10)
    private String prioridad;

    @Column(nullable = false, length = 500)
    private String descripcion;

    @Column(nullable = false, length = 15)
    private String estado;

    @Column(name = "fecha_registro", nullable = false)
    private LocalDateTime fechaRegistro;

    protected Reporte() { }

    public Reporte(String tipoEspacio, String espacio, String tipoReporte,
                   String prioridad, String descripcion) {
        this.tipoEspacio = tipoEspacio;
        this.espacio = espacio;
        this.tipoReporte = tipoReporte;
        this.prioridad = prioridad;
        this.descripcion = descripcion;
        this.estado = "Pendiente";
        this.fechaRegistro = LocalDateTime.now();
    }

    public Long getId() { return id; }
    public String getTipoEspacio() { return tipoEspacio; }
    public String getEspacio() { return espacio; }
    public String getTipoReporte() { return tipoReporte; }
    public String getPrioridad() { return prioridad; }
    public String getDescripcion() { return descripcion; }
    public String getEstado() { return estado; }


    // REP-0001, REP-0002, ... (sale del id que genera la base de datos)
    public String getNumero() {
        return "REP-" + String.format("%04d", id);
    }

    public String getFecha() {
        return fechaRegistro.format(DateTimeFormatter.ofPattern("dd/MM/yyyy"));
    }

    public String getHora() {
        return fechaRegistro.format(DateTimeFormatter.ofPattern("HH:mm"));
    }

    public String mostrarInformacion() {
        return getNumero() + " - " + tipoEspacio + " - " + espacio;
    }
}