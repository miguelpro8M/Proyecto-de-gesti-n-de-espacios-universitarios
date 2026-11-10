
const buscarZona = document.getElementById("buscarZona");
const tipoZona = document.getElementById("tipoZona");
const tarjetas = document.querySelectorAll(".zona");
const sinResultadosZonas = document.getElementById("sinResultadosZonas");


function filtrarZonas() {

    const texto = buscarZona.value.toLowerCase().trim();

    let visibles = 0;

    tarjetas.forEach(function (tarjeta) {

        const coincideNombre =
            tarjeta.dataset.nombre.toLowerCase().includes(texto);

        const coincideTipo =
            tipoZona.value === "todos" ||
            tarjeta.dataset.tipo === tipoZona.value;

        const mostrar = coincideNombre && coincideTipo;

        tarjeta.style.display = mostrar ? "" : "none";

        if (mostrar) {
            visibles++;
        }

    });

    sinResultadosZonas.style.display = visibles === 0 ? "block" : "none";

}


buscarZona.addEventListener("input", filtrarZonas);
tipoZona.addEventListener("change", filtrarZonas);