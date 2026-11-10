package org.example.servicio;

import jakarta.ejb.Stateless;
import jakarta.persistence.EntityManager;
import jakarta.persistence.PersistenceContext;
import org.example.modelo.Reporte;

import java.util.List;

@Stateless
public class ReporteService {

    @PersistenceContext(unitName = "gestionPU")
    private EntityManager em;

    public Reporte crear(String tipoEspacio, String espacio, String tipoReporte,
                         String prioridad, String descripcion) {

        Reporte reporte = new Reporte(tipoEspacio, espacio, tipoReporte, prioridad, descripcion);
        em.persist(reporte);
        return reporte;
    }

    public List<Reporte> listar() {
        return em.createQuery("SELECT r FROM Reporte r ORDER BY r.id", Reporte.class)
                .getResultList();
    }
}