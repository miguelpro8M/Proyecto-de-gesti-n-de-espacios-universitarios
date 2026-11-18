package org.example.faces;

import jakarta.enterprise.context.SessionScoped;
import jakarta.faces.application.FacesMessage;
import jakarta.faces.context.ExternalContext;
import jakarta.faces.context.FacesContext;
import jakarta.inject.Named;
import org.example.modelo.Reserva;

import java.io.IOException;
import java.io.Serializable;
import java.util.ArrayList;
import java.util.List;

// Bean CDI: guarda los datos del formulario y la lista de reservas durante la sesion del usuario.
// #{reservas} es el nombre que usa la pagina reservas.xhtml
@Named("reservas")
@SessionScoped
public class ReservaBean implements Serializable {

    private static final long serialVersionUID = 1L;

    private static final List<String> SALONES = List.of(
            "A-101", "A-102", "A-201", "B-101", "B-201", "C-301", "C-302", "C-303");

    // Campos del formulario
    private String solicitante;
    private String salon;
    private Integer horas;

    // Reservas registradas en esta sesion
    private final List<Reserva> lista = new ArrayList<>();

    // Accion del boton "Agregar reserva": solo se ejecuta si todas las validaciones pasaron
    public String agregar() {

        String nombre = (solicitante == null) ? "" : solicitante.trim();

        // Un nombre formado solo por espacios pasa "required"; aqui se rechaza
        if (nombre.isEmpty()) {
            mensaje(FacesMessage.SEVERITY_ERROR, "El nombre del solicitante no puede estar vacío.");
            return null;
        }

        lista.add(new Reserva(nombre, salon, horas));

        // Se limpian los campos para el siguiente registro
        solicitante = null;
        salon = null;
        horas = null;

        mensaje(FacesMessage.SEVERITY_INFO, "Reserva registrada correctamente.");

        // null = se queda en la misma pagina
        return null;
    }

    public void verificarSesion() throws IOException {
        ExternalContext externo = FacesContext.getCurrentInstance().getExternalContext();

        if (externo.getSessionMap().get("usuario") == null) {
            externo.redirect(externo.getRequestContextPath() + "/login.jsp");
        }
    }

    private void mensaje(FacesMessage.Severity tipo, String texto) {
        FacesContext.getCurrentInstance().addMessage(null, new FacesMessage(tipo, texto, null));
    }

    // Getters y setters

    public String getSolicitante() { return solicitante; }
    public void setSolicitante(String solicitante) { this.solicitante = solicitante; }

    public String getSalon() { return salon; }
    public void setSalon(String salon) { this.salon = salon; }

    public Integer getHoras() { return horas; }
    public void setHoras(Integer horas) { this.horas = horas; }

    public List<Reserva> getLista() { return lista; }

    // Contador de la pagina
    public int getTotal() { return lista.size(); }

    public List<String> getSalonesDisponibles() { return SALONES; }
}