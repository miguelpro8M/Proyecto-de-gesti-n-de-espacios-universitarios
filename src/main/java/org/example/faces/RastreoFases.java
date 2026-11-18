package org.example.faces;

import jakarta.faces.context.FacesContext;
import jakarta.faces.event.PhaseEvent;
import jakarta.faces.event.PhaseId;
import jakarta.faces.event.PhaseListener;
import jakarta.servlet.http.HttpServletRequest;

import java.util.logging.Logger;

public class RastreoFases implements PhaseListener {

    private static final long serialVersionUID = 1L;
    private static final Logger LOG = Logger.getLogger(RastreoFases.class.getName());

    @Override
    public void beforePhase(PhaseEvent evento) {

        if (evento.getPhaseId() == PhaseId.RESTORE_VIEW) {
            HttpServletRequest solicitud = (HttpServletRequest) evento
                    .getFacesContext()
                    .getExternalContext()
                    .getRequest();

            String metodo = solicitud.getMethod();
            LOG.info("===== NUEVA PETICION " + metodo + " =====");
        }

        LOG.info("INICIO " + evento.getPhaseId());
    }

    @Override
    public void afterPhase(PhaseEvent evento) {

        LOG.info("FIN    " + evento.getPhaseId());

        FacesContext contexto = evento.getFacesContext();

        if (evento.getPhaseId() == PhaseId.PROCESS_VALIDATIONS && contexto.isValidationFailed()) {
            LOG.info("   -> Validacion fallida: se salta a RENDER_RESPONSE "
                    + "(no se actualiza el bean ni se ejecuta la accion)");
        }
    }

    @Override
    public PhaseId getPhaseId() {
        return PhaseId.ANY_PHASE;
    }
}
