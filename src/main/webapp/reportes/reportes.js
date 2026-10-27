// Solo maneja la pantalla: el segundo select depende del primero.
// El registro y la validacion de los reportes los hace ReporteServlet.

const formulario = document.getElementById("formularioReporte");
const tipoEspacio = document.getElementById("tipoEspacio");
const espacio = document.getElementById("espacio");


function agregarOpcion(valor, texto) {

    const opcion = document.createElement("option");
    opcion.value = valor;
    opcion.textContent = texto;
    espacio.appendChild(opcion);

}


function cargarEspacios() {

    espacio.innerHTML = "";

    // si no selecciono nada
    if (tipoEspacio.value === "") {
        espacio.disabled = true;
        agregarOpcion("", "Primero seleccione el tipo de espacio");
        return;
    }

    espacio.disabled = false;
    agregarOpcion("", "Seleccione un espacio");

    let lista = "";

    if (tipoEspacio.value === "Salón") {
        lista = espacio.dataset.salones;
    }

    if (tipoEspacio.value === "Zona recreativa") {
        lista = espacio.dataset.zonas;
    }

    lista.split("|").forEach(function (nombre) {
        if (nombre !== "") {
            agregarOpcion(nombre, nombre);
        }
    });

}


tipoEspacio.addEventListener("change", cargarEspacios);



formulario.addEventListener("reset", function () {
    setTimeout(cargarEspacios, 0);
});


cargarEspacios();
