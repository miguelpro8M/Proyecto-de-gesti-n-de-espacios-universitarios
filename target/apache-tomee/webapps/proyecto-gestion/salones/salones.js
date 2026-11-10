const buscar = document.getElementById("buscar");
const edificio = document.getElementById("edificio");
const tipo = document.getElementById("tipo");
const tarjetas = document.querySelectorAll(".salon");
const contador = document.getElementById("contadorDisponibles");
const sinResultados = document.getElementById("sinResultados");


function filtrarSalones() {

    const texto = buscar.value.toLowerCase().trim();

    let visibles = 0;
    let disponibles = 0;

    tarjetas.forEach(function (tarjeta) {

        const coincideNombre =
            tarjeta.dataset.nombre.toLowerCase().includes(texto);

        const coincideEdificio =
            edificio.value === "todos" ||
            tarjeta.dataset.edificio === edificio.value;

        const coincideTipo =
            tipo.value === "todos" ||
            tarjeta.dataset.tipo === tipo.value;

        const mostrar = coincideNombre && coincideEdificio && coincideTipo;

        tarjeta.style.display = mostrar ? "" : "none";

        if (mostrar) {
            visibles++;
            if (tarjeta.dataset.estado === "Disponible") {
                disponibles++;
            }
        }

    });

    contador.textContent =
        disponibles + " de " + visibles + " salones disponibles";

    sinResultados.style.display = visibles === 0 ? "block" : "none";

}



buscar.addEventListener("input", filtrarSalones);
edificio.addEventListener("change", filtrarSalones);
tipo.addEventListener("change", filtrarSalones);



document.querySelectorAll(".form-estado").forEach(function (formulario) {

    formulario.addEventListener("submit", function () {
        formulario.elements["buscar"].value = buscar.value;
        formulario.elements["edificio"].value = edificio.value;
        formulario.elements["tipo"].value = tipo.value;
    });

});


filtrarSalones();