package org.example.servicio;

import jakarta.ejb.Remove;
import jakarta.ejb.Stateful;

import java.util.ArrayList;
import java.util.List;

@Stateful
public class ReservaTemporal {

    private final List<String> salones = new ArrayList<>();

    public void agregar(String salon) {
        salones.add(salon);
    }

    public List<String> consultar() {
        return List.copyOf(salones);
    }

    @Remove
    public void finalizar() {
        salones.clear();
    }
}
