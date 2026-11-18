package org.example.faces;

import jakarta.annotation.PostConstruct;
import jakarta.faces.context.ExternalContext;
import jakarta.faces.context.FacesContext;
import jakarta.faces.view.ViewScoped;
import jakarta.inject.Named;
import org.example.Salon;
import org.example.SalonDAO;

import java.io.IOException;
import java.io.Serializable;
import java.sql.SQLException;
import java.util.logging.Logger;

@Named("cicloBean")
@ViewScoped
public class CicloBean implements Serializable {

    private static final long serialVersionUID = 1L;
    private static final Logger LOG = Logger.getLogger(CicloBean.class.getName());

    private String codigo;      // lo que escribe el usuario
    private String resultado;   // texto que muestra la pagina
    private int consultas;      // cuantas consultas validas se hicieron en esta vista

    @PostConstruct
    public void iniciar() {
        LOG.info("   [Bean] CicloBean creado: vista nueva (@ViewScoped)");
    }

    public void consultar() {

        LOG.info("   [Bean] consultar() EJECUTADO -> fase INVOKE_APPLICATION, codigo = " + codigo);

        String buscado = (codigo == null) ? "" : codigo.trim();

        // Un codigo formado solo por espacios pasa "required"; aqui se rechaza
        if (buscado.isEmpty()) {
            resultado = "Escriba un código de salón válido.";
            return;
        }

        consultas++;

        try {
            Salon salon = new SalonDAO().buscarPorNombre(buscado);

            if (salon == null) {
                resultado = "No existe un salón con el código " + buscado + ".";
            } else {
                resultado = "Salón " + salon.getNombre() + ": " + salon.getEstado()
                        + " (" + salon.getTipoNombre() + ", edificio " + salon.getEdificio()
                        + ", capacidad " + salon.getCapacidad() + " personas).";
            }
        } catch (SQLException e) {
            LOG.warning("   [Bean] Error de base de datos: " + e.getMessage());
            resultado = "No se pudo consultar la base de datos.";
        }
    }

    // Se ejecuta antes de dibujar la pagina: si no hay sesion iniciada, manda al login
    public void verificarSesion() throws IOException {
        ExternalContext externo = FacesContext.getCurrentInstance().getExternalContext();

        if (externo.getSessionMap().get("usuario") == null) {
            externo.redirect(externo.getRequestContextPath() + "/login.jsp");
        }
    }

    // Getters y setters

    public String getCodigo() { return codigo; }

    public void setCodigo(String codigo) {
        LOG.info("   [Bean] setCodigo(\"" + codigo + "\") -> fase UPDATE_MODEL_VALUES");
        this.codigo = codigo;
    }

    public String getResultado() { return resultado; }

    public int getConsultas() { return consultas; }
}
