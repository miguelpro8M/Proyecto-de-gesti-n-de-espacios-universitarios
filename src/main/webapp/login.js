/*
// formulario
const loginForm = document.getElementById("loginForm");


loginForm.addEventListener("submit", function(event) {

    event.preventDefault();

    // Obtener los datos
    const usuario = document.getElementById("usuario").value;
    const password = document.getElementById("password").value;

    // error
    const mensajeError = document.getElementById("mensajeError");


    // Datos de prueba
    const usuarioCorrecto = "admin";
    const passwordCorrecta = "12345";


    // Comprueba usuario y contraseña
    if (
        usuario === usuarioCorrecto &&
        password === passwordCorrecta
    ) {

        // Guarda el usuario durante la sesion
        sessionStorage.setItem("usuario", usuario);

        window.location.href = "inicio.html";

    } else {

        mensajeError.textContent =
            "Usuario o contraseña incorrectos.";

    }

});

 */