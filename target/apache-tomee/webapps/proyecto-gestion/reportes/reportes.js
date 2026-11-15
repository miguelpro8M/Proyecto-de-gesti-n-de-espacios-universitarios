// Solo maneja la pantalla: el segundo select depende del primero.
// El registro y la validacion de los reportes los hace ReporteServlet.
// Los textos y los nombres llegan desde la JSP en atributos data-
// (asi se traducen igual que el resto de la pagina).

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

    const textoPrimero = espacio.dataset.textoPrimero || "Primero seleccione el tipo de espacio";
    const textoElegir = espacio.dataset.textoElegir || "Seleccione un espacio";

    // si no selecciono nada
    if (tipoEspacio.value === "") {
        espacio.disabled = true;
        agregarOpcion("", textoPrimero);
        return;
    }

    espacio.disabled = false;
    agregarOpcion("", textoElegir);

    // los nombres los entrega la JSP en atributos data-
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


// el boton Limpiar: se espera a que el navegador limpie los campos
// y despues se reinicia el segundo select

formulario.addEventListener("reset", function () {
    setTimeout(cargarEspacios, 0);
});


cargarEspacios();