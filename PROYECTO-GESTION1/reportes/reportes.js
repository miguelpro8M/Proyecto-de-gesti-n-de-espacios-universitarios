// clase reporte

class Reporte {

    constructor(
        numero,
        tipoEspacio,
        espacio,
        tipoReporte,
        prioridad,
        descripcion,
        fecha,
        hora
    ) {

        this.numero = numero;
        this.tipoEspacio = tipoEspacio;
        this.espacio = espacio;
        this.tipoReporte = tipoReporte;
        this.prioridad = prioridad;
        this.descripcion = descripcion;
        this.fecha = fecha;
        this.hora = hora;
        this.estado = "Pendiente";
    }

    // metodo de la clase

    mostrarInformacion() {

        return (
            this.numero +
            " - " +
            this.tipoEspacio +
            " - " +
            this.espacio
        );
    }
}

// elementos html

const formularioReporte =
    document.getElementById("formularioReporte");

const tipoEspacio =
    document.getElementById("tipoEspacio");

const espacio =
    document.getElementById("espacio");

const listaReportes =
    document.getElementById("listaReportes");


// listas de espacios

const salones = [

    "A-101",
    "A-102",
    "A-201",
    "B-101",
    "B-201",
    "C-301",
    "C-302",
    "C-303"

];

const zonas = [

    "Cancha 1",
    "Cancha 2",
    "Cancha 3",
    "Cancha 4",
    "Gimnasio",
    "Zona de ping-pong",
    "Bolirana",
    "Juegos recreativos",
    "Biblioteca"

];

// arreglo de objetos

const reportes = [];

// evento change

tipoEspacio.addEventListener(
    "change",
    function() {

        // limpiar opciones
        espacio.innerHTML = "";

        // si no selecciono nada

        if (tipoEspacio.value === "") {

            espacio.disabled = true;

            const opcion =
                document.createElement("option");

            opcion.value = "";

            opcion.textContent =
                "Primero seleccione el tipo de espacio";

            espacio.appendChild(opcion);

            return;

        }

        // activar selector
        espacio.disabled = false;

        // opcion inicial

        const opcionInicial =
            document.createElement("option");

        opcionInicial.value = "";

        opcionInicial.textContent =
            "Seleccione un espacio";
        espacio.appendChild(opcionInicial);

        // seleccionar lista

        let lista = [];

        if (tipoEspacio.value === "Salón") {
            lista = salones;
        }

        if (
            tipoEspacio.value ===
            "Zona recreativa"
        ) {
            lista = zonas;
        }

        // crear opciones

        lista.forEach(function(nombre) {

            const opcion =
                document.createElement("option");

            opcion.value = nombre;

            opcion.textContent = nombre;

            espacio.appendChild(opcion);

        });

    }
);

// evento submit
formularioReporte.addEventListener(
    "submit",
    function(event) {

        // evitar recargar la pagina
        event.preventDefault();

        // obtener datos

        const tipo =
            tipoEspacio.value;

        const nombreEspacio =
            espacio.value;

        const tipoReporte =
            document.getElementById(
                "tipoReporte"
            ).value;

        const prioridad =
            document.getElementById(
                "prioridad"
            ).value;

        const descripcion =
            document.getElementById(
                "descripcion"
            ).value;

        //generar num

        const numeroReporte =
            "REP-" +
            String(reportes.length + 1)
                .padStart(4, "0");

        // fecha y hora
        const ahora = new Date();

        const fecha =
            ahora.toLocaleDateString("es-CO");


        const hora =
            ahora.toLocaleTimeString(
                "es-CO",
                {
                    hour: "2-digit",
                    minute: "2-digit"
                }
            );

        // crear objeto
        const nuevoReporte =
            new Reporte(

                numeroReporte,
                tipo,
                nombreEspacio,
                tipoReporte,
                prioridad,
                descripcion,
                fecha,
                hora

            );

        // agregar al arreglo
        reportes.push(nuevoReporte);

        // mostrar r
        mostrarReportes();

        // limpiar formulario
        formularioReporte.reset();

        espacio.disabled = true;
        espacio.innerHTML = `

            <option value="">
                Primero seleccione el tipo de espacio
            </option>

        `;

        // mensjae
        alert(
            "Reporte registrado correctamente.\n\n" +
            "Número de reporte: " +
            numeroReporte
        );

    }
);

// funcion mostrar reportes

function mostrarReportes() {
    // Limpiar contenido
    listaReportes.innerHTML = "";

    // Recorrer arreglo de objetos
    reportes.forEach(
        function(reporte) {

            // Crear tarjeta
            const tarjeta =
                document.createElement("article");

            tarjeta.classList.add(
                "tarjeta-reporte"
            );

            // clase de prioridad

            let clasePrioridad = "";

            if (reporte.prioridad === "Baja") {
                clasePrioridad =
                    "prioridad-baja";
            }

            if (reporte.prioridad === "Media") {
                clasePrioridad =
                    "prioridad-media";
            }

            if (reporte.prioridad === "Alta") {
                clasePrioridad =
                    "prioridad-alta";
            }

            // se usa metodo de objeto
            const informacion =
                reporte.mostrarInformacion();

            // html

            tarjeta.innerHTML = `

                <div class="reporte-cabecera">

                    <h3>
                        ${reporte.numero}
                    </h3>

                    <span class="estado-reporte">
                        ${reporte.estado}
                    </span>

                </div>

                <p>
                    <strong>Información:</strong>
                    ${informacion}
                </p>


                <p>
                    <strong>Tipo de reporte:</strong>
                    ${reporte.tipoReporte}
                </p>

                <p>
                    <strong>Prioridad:</strong>

                    <span class="${clasePrioridad}">
                        ${reporte.prioridad}
                    </span>

                </p>

                <p>
                    <strong>Descripción:</strong>
                    ${reporte.descripcion}
                </p>

                <p class="fecha-reporte">

                    Registrado el
                    ${reporte.fecha}

                    a las
                    ${reporte.hora}

                </p>

            `;
            // Agrega tarjeta a la pagina

            listaReportes.appendChild(tarjeta);
        }
    );
}