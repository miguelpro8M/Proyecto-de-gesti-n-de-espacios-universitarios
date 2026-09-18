// elementos html

const btnCerrarSesion =
    document.getElementById("btnCerrarSesion");


// funcion cerrar sesion

function cerrarSesion() {

    sessionStorage.removeItem("usuario");
    window.location.href = "index.html";

}


// evento click

btnCerrarSesion.addEventListener(
    "click",
    cerrarSesion
);
