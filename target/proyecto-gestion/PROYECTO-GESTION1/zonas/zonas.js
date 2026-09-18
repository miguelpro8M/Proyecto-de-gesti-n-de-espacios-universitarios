// lista de zonas recreativas

const zonas = [

    // canchas

    {
        nombre: "Cancha 1",
        tipo: "deportiva",
        tipoNombre: "Deportiva",
        ubicacion: "Zona deportiva",
        capacidad: 20,
        estado: "Disponible",
        icono: "🏟️"
    },

    {
        nombre: "Cancha 2",
        tipo: "deportiva",
        tipoNombre: "Deportiva",
        ubicacion: "Zona deportiva",
        capacidad: 20,
        estado: "Disponible",
        icono: "🏟️"
    },

    {
        nombre: "Cancha 3",
        tipo: "deportiva",
        tipoNombre: "Deportiva",
        ubicacion: "Zona deportiva",
        capacidad: 20,
        estado: "Ocupado",
        icono: "🏟️"
    },

    {
        nombre: "Cancha 4",
        tipo: "deportiva",
        tipoNombre: "Deportiva",
        ubicacion: "Zona deportiva",
        capacidad: 20,
        estado: "Disponible",
        icono: "🏟️"
    },

    // gim

    {
        nombre: "Gimnasio",
        tipo: "gimnasio",
        tipoNombre: "Gimnasio",
        ubicacion: "Zona deportiva",
        capacidad: 30,
        estado: "Disponible",
        icono: "🏋️"
    },

    // zonas recreativas

    {
        nombre: "Zona de ping-pong",
        tipo: "recreativa",
        tipoNombre: "Recreativa",
        ubicacion: "Zona recreativa",
        capacidad: 6,
        estado: "Disponible",
        icono: "🏓"
    },

    {
        nombre: "Bolirana",
        tipo: "recreativa",
        tipoNombre: "Recreativa",
        ubicacion: "Zona recreativa",
        capacidad: 10,
        estado: "Disponible",
        icono: "🎯"
    },

    {
        nombre: "Juegos recreativos",
        tipo: "recreativa",
        tipoNombre: "Recreativa",
        ubicacion: "Zona recreativa",
        capacidad: 10,
        estado: "Disponible",
        icono: "🎲"
    },

    // biblioteca

    {
        nombre: "Biblioteca",
        tipo: "descanso",
        tipoNombre: "Biblioteca",
        ubicacion: "Edificio principal",
        capacidad: 50,
        estado: "Disponible",
        icono: "📚"
    }

];

// elementos html

const buscarZona =
    document.getElementById("buscarZona");

const tipoZona =
    document.getElementById("tipoZona");

const listaZonas =
    document.getElementById("listaZonas");

const sinResultadosZonas =
    document.getElementById("sinResultadosZonas");


// mostrar zonas

function mostrarZonas(lista) {

    // limpiar la lista
    listaZonas.innerHTML = "";


    // Comprueba si existen resultados
    if (lista.length === 0) {

        sinResultadosZonas.style.display = "block";

        return;
    }

    // ocultar mensaje
    sinResultadosZonas.style.display = "none";

    // crear las tarjetas
    lista.forEach(function(zona) {

        const tarjeta =
            document.createElement("article");


        tarjeta.classList.add("zona");

        // estado
        let claseEstado = "";

        if (zona.estado === "Disponible") {

            claseEstado = "disponible-zona";

        } else {

            claseEstado = "ocupado-zona";

        }

        // Crear contenido
        tarjeta.innerHTML = `

            <div class="zona-icono">

                ${zona.icono}

            </div>


            <div class="zona-informacion">

                <h3>
                    ${zona.nombre}
                </h3>

                <p>
                    <strong>Tipo:</strong>
                    ${zona.tipoNombre}
                </p>

                <p>
                    <strong>Ubicación:</strong>
                    ${zona.ubicacion}
                </p>

                <p>
                    <strong>Capacidad:</strong>
                    ${zona.capacidad} personas
                </p>

            </div>


            <div class="estado-zona ${claseEstado}">

                ${zona.estado}

            </div>

        `;

        // Agregar tarjeta
        listaZonas.appendChild(tarjeta);

    });

}

// filtrar zonas

function filtrarZonas() {

    // Texto de busqueda
    const texto =
        buscarZona.value.toLowerCase().trim();

    // Tipo seleccionado
    const tipoSeleccionado =
        tipoZona.value;

    // Filtrar
    const resultados =
        zonas.filter(function(zona) {


            // nombre
            const coincideNombre =
                zona.nombre
                    .toLowerCase()
                    .includes(texto);


            // tipo
            const coincideTipo =
                tipoSeleccionado === "todos" ||
                zona.tipo === tipoSeleccionado;

            // Debe cumplir ambas condiciones
            return (
                coincideNombre &&
                coincideTipo
            );

        });

    // Mostrar resultados
    mostrarZonas(resultados);

}


// eventos


// buscar mientras se escribe

buscarZona.addEventListener(
    "input",
    filtrarZonas
);

// cambiar tipo

tipoZona.addEventListener(
    "change",
    filtrarZonas
);

// mostrar todas al cargar

mostrarZonas(zonas);