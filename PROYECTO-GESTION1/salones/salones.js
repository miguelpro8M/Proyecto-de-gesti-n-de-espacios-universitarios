// lista de salones

const salones = [

    {
        nombre: "A-101",
        edificio: "A",
        piso: 1,
        tipo: "aula",
        tipoNombre: "Aula",
        capacidad: 30,
        estado: "Disponible"
    },

    {
        nombre: "A-102",
        edificio: "A",
        piso: 1,
        tipo: "computadores",
        tipoNombre: "Sala de computadores",
        capacidad: 40,
        estado: "Ocupado"
    },

    {
        nombre: "A-201",
        edificio: "A",
        piso: 2,
        tipo: "aula",
        tipoNombre: "Aula",
        capacidad: 35,
        estado: "Disponible"
    },

    {
        nombre: "B-101",
        edificio: "B",
        piso: 1,
        tipo: "laboratorio",
        tipoNombre: "Laboratorio",
        capacidad: 25,
        estado: "Disponible"
    },

    {
        nombre: "B-201",
        edificio: "B",
        piso: 2,
        tipo: "computadores",
        tipoNombre: "Sala de computadores",
        capacidad: 30,
        estado: "Ocupado"
    },

    {
        nombre: "C-301",
        edificio: "C",
        piso: 3,
        tipo: "auditorio",
        tipoNombre: "Auditorio",
        capacidad: 100,
        estado: "Disponible"
    },

    {
        nombre: "C-302",
        edificio: "C",
        piso: 3,
        tipo: "laboratorio",
        tipoNombre: "Laboratorio",
        capacidad: 30,
        estado: "Disponible"
    },

    {
        nombre: "C-303",
        edificio: "C",
        piso: 3,
        tipo: "aula",
        tipoNombre: "Aula",
        capacidad: 40,
        estado: "Ocupado"
    }

];

// elementos html

const buscarSalon =
    document.getElementById("buscarSalon");

const edificio =
    document.getElementById("edificio");

const tipoSalon =
    document.getElementById("tipoSalon");

const listaSalones =
    document.getElementById("listaSalones");

const sinResultados =
    document.getElementById("sinResultados");

const contadorDisponibles =
    document.getElementById("contadorDisponibles");


// mostrar salones

function mostrarSalones(lista) {

    // Limpia la lista actual
    listaSalones.innerHTML = "";

    // comprueba si existen resultados
    if (lista.length === 0) {
        sinResultados.style.display = "block";
        contadorDisponibles.textContent =
            "0 de 0 salones disponibles";
        return;

    }

    // Ocultar mensaje
    sinResultados.style.display = "none";


    // crear cada salon
    lista.forEach(function(salon) {

        const tarjeta = document.createElement("article");
        tarjeta.classList.add("salon");

        // estado
        let claseEstado = "";

        if (salon.estado === "Disponible") {
            claseEstado = "disponible";

        } else {

            claseEstado = "ocupado";

        }

        // Crear contenido
        tarjeta.innerHTML = `

            <div class="salon-icono">
                🏫
            </div>


            <div class="salon-informacion">

                <h3>
                    Salón ${salon.nombre}
                </h3>

                <p>
                    <strong>Edificio:</strong>
                    ${salon.edificio}
                </p>

                <p>
                    <strong>Piso:</strong>
                    ${salon.piso}
                </p>

                <p>
                    <strong>Tipo:</strong>
                    ${salon.tipoNombre}
                </p>

                <p>
                    <strong>Capacidad:</strong>
                    ${salon.capacidad} personas
                </p>

                <button
                    class="btn-estado-salon"
                    data-nombre="${salon.nombre}"
                >
                    ${salon.estado === "Disponible" ? "Reservar salón" : "Liberar salón"}
                </button>

            </div>


            <div class="estado ${claseEstado}">

                ${salon.estado}

            </div>

        `;

        // agregar tarjeta a la pagina
        listaSalones.appendChild(tarjeta);

    });

    // actualizar el contador de disponibles
    actualizarContadorDisponibles();

}


function actualizarContadorDisponibles() {

    const tarjetasDisponibles =
        listaSalones.querySelectorAll(".disponible");

    const totalTarjetas =
        listaSalones.querySelectorAll(".salon");

    contadorDisponibles.textContent =
        tarjetasDisponibles.length +
        " de " +
        totalTarjetas.length +
        " salones disponibles";

}

// =filtrar salon

function filtrarSalones() {

    // obtener texto de busqueda
    const texto =
        buscarSalon.value.toLowerCase().trim();

    // obtener edificio seleccionado
    const edificioSeleccionado =
        edificio.value;

    // obtener tipo seleccionado
    const tipoSeleccionado =
        tipoSalon.value;

    // Filtrar
    const resultados = salones.filter(function(salon) {

        //  nombre
        const coincideNombre =
            salon.nombre.toLowerCase().includes(texto);

        //  edificio
        const coincideEdificio =
            edificioSeleccionado === "todos" ||
            salon.edificio === edificioSeleccionado;

        //  tipo
        const coincideTipo =
            tipoSeleccionado === "todos" ||
            salon.tipo === tipoSeleccionado;

        // tres condiciones
        return (
            coincideNombre &&
            coincideEdificio &&
            coincideTipo
        );

    });

    mostrarSalones(resultados);

}

// cambiar estado de un salon

function cambiarEstadoSalon(nombreSalon) {

    // buscar el salon dentro del arreglo
    const salon = salones.find(function(s) {

        return s.nombre === nombreSalon;

    });

    // si existe, se alterna su estado
    if (salon) {

        if (salon.estado === "Disponible") {
            salon.estado = "Ocupado";
        } else {
            salon.estado = "Disponible";
        }

        // se vuelve a mostrar respetando el filtro/busqueda actual
        filtrarSalones();

    }

}

// eventos

// buscar mientras se escribe
buscarSalon.addEventListener(
    "input",
    filtrarSalones
);

// cambiar edificio
edificio.addEventListener(
    "change",
    filtrarSalones
);

// cambiar tipo
tipoSalon.addEventListener(
    "change",
    filtrarSalones
);

listaSalones.addEventListener(
    "click",
    function(event) {

        if (
            event.target.classList.contains(
                "btn-estado-salon"
            )
        ) {

            const nombreSalon =
                event.target.dataset.nombre;

            cambiarEstadoSalon(nombreSalon);

        }

    }
);

// mostrar todos los salones al cargar

mostrarSalones(salones);