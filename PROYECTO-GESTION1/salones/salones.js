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


// mostrar salones

function mostrarSalones(lista) {

    // Limpia la lista actual
    listaSalones.innerHTML = "";

    // comprueba si existen resultados
    if (lista.length === 0) {
        sinResultados.style.display = "block";
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

            </div>


            <div class="estado ${claseEstado}">

                ${salon.estado}

            </div>

        `;

        // Agregar tarjeta a la página
        listaSalones.appendChild(tarjeta);

    });

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

// mostrar todos los salones al cargar

mostrarSalones(salones);