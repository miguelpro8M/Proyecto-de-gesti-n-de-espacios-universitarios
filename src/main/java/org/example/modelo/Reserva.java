package org.example.modelo;

import java.io.Serializable;

// Una solicitud de reserva de salon (vive en la sesion del usuario, no en la base de datos)
public class Reserva implements Serializable {

    private static final long serialVersionUID = 1L;

    private final String solicitante;
    private final String salon;
    private final Integer horas;

    public Reserva(String solicitante, String salon, Integer horas) {
        this.solicitante = solicitante;
        this.salon = salon;
        this.horas = horas;
    }

    public String getSolicitante() { return solicitante; }
    public String getSalon() { return salon; }
    public Integer getHoras() { return horas; }
}
