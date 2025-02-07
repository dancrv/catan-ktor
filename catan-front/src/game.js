import 'bootstrap/dist/css/bootstrap.min.css';
import './style.css';
import { showAlert } from './main';

const apiUrl = 'http://127.0.0.1:8080';
const usuario = JSON.parse(localStorage.getItem('usuario'));
const nuevaPartidaBtn = document.getElementById('newGameBtn');
const tableroContainer = document.getElementById('tableroContainer');

const crearPartida = async () => {
    if (!usuario || !usuario.id) {
        showAlert("⚠️ No has iniciado sesión.", 'danger');
        window.location.href = "/src/login.html";
        return;
    }

    try {
        const response = await fetch(`${apiUrl}/crearPartida`, {
            method: "POST",
            headers: { 
                "Content-Type": "application/json",
                "Authorization": `Bearer ${usuario.token}` 
            },
            body: JSON.stringify({ id_jugador: usuario.id })
        });
        
        const data = await response.json();
        if (response.ok) {
            showAlert("✅ Partida creada con éxito.", 'success');
            localStorage.setItem("partida", JSON.stringify(data));
            nuevaPartidaBtn.disabled = true;
            pintarTablero(data.tablero); 
        } else {
            showAlert(`❌ Error al crear partida: ${data.msg}`, 'danger');
        }
    } catch (error) {
        showAlert("❌ Error en la conexión con el servidor.", 'danger');
    }
};

const pintarTablero = (tablero) => {
    if (!tablero || tablero.length === 0) {
        tableroContainer.innerHTML = "<p class='text-center text-danger'>⚠️ No hay tablero disponible.</p>";
        return;
    }

    const recursos = {
        "MADERA": { imagen: "/img/forest.png", emoji: "🌲", nombre: "MADERA" },
        "TRIGO": { imagen: "/img/field.png", emoji: "🌾", nombre: "TRIGO" },
        "CARBON": { imagen: "/img/mountain.png", emoji: "⛏️", nombre: "CARBÓN" }
    };

    let html = `<div class="tablero-grid">`;

    tablero.forEach(casilla => {
        const recurso = recursos[casilla.recurso] || { imagen: "/img/default.png", emoji: "❓", nombre: "DESCONOCIDO" };

        let borde = "none";
        if (casilla.propietario === "JUGADOR") borde = "3px solid #fff";
        if (casilla.propietario === "SERVIDOR") borde = "3px solid #8f1d27";

        html += `
            <div class="casilla shadow" data-id="${casilla.id}" data-propietario="${casilla.propietario}" style="
                background-image: url('${recurso.imagen}');
                background-size: cover;
                border: ${borde};
                display: flex;
                align-items: center;
                justify-content: center;
                font-size: 1.5rem;
                font-weight: bold;
                width: 150px;
                height: 150px;
                margin: 5px;
                color: white;
                text-shadow: 2px 2px 4px rgb(0, 0, 0);
            ">
                <div class="recurso rounded">
                    <p class="m-0">${recurso.nombre}</p>
                    <p class="m-0">${casilla.valorDado}</p>
                    <p class="m-0">${recurso.emoji}</p>
                </div>
            </div>
        `;
    });

    html += '</div>';
    tableroContainer.innerHTML = html;
    
    attachCasillaClickListeners();
};

const attachCasillaClickListeners = () => {
    const casillaElements = document.querySelectorAll(".casilla");
    casillaElements.forEach(casillaEl => {
        casillaEl.addEventListener("click", () => {
            const propietario = casillaEl.getAttribute("data-propietario");
            if (propietario !== "LIBRE") {
                showAlert("❕Esta casilla ya está ocupada.", "warning");
                return;
            }

            const idCasilla = casillaEl.getAttribute("data-id");
            if (!idCasilla) return;
 
            seleccionarCasilla(parseInt(idCasilla));
        });
    });
};

const seleccionarCasilla = async (idCasilla) => {
    const partidaGuardada = JSON.parse(localStorage.getItem("partida"));
    if (!partidaGuardada || !partidaGuardada.id) {
        showAlert("⚠️ No hay partida activa.", "danger");
        return;
    }

    try {
        const response = await fetch(`${apiUrl}/partidas/seleccionarCasilla`, {
            method: "POST",
            headers: { 
                "Content-Type": "application/json",
                "Authorization": `Bearer ${usuario.token}` 
            },
            body: JSON.stringify({
                id_partida: partidaGuardada.id,
                id_casilla: idCasilla
            })
        });
        const data = await response.json();
        if (response.ok) {
            localStorage.setItem("partida", JSON.stringify(data));
            pintarTablero(data.tablero);
        } else {
            showAlert(`❌ Error: ${data.msg}`, "danger");
        }
    } catch (error) {
        showAlert("❌ Error en la conexión con el servidor.", "danger");
    }
};

if (nuevaPartidaBtn) {
    nuevaPartidaBtn.addEventListener("click", crearPartida);
}

document.addEventListener("DOMContentLoaded", () => {
    const partidaGuardada = JSON.parse(localStorage.getItem("partida"));
    if (partidaGuardada) {
        showAlert("⏳ Continuando partida en progreso...", 'info');
        pintarTablero(partidaGuardada.tablero);
        
        if (partidaGuardada && partidaGuardada.estado === "EN_CURSO") {
            nuevaPartidaBtn.disabled = true;
        }
    }
});

const abandonarPartidaBtn = document.getElementById("abandonarPartidaBtn");

const abandonarPartida = async () => {
    const partidaGuardada = JSON.parse(localStorage.getItem("partida"));

    if (!partidaGuardada || !partidaGuardada.id) {
        showAlert("⚠️ No hay partida activa.", "danger");
        return;
    }

    try {
        const response = await fetch(`${apiUrl}/partidas/abandonar`, {
            method: "POST",
            headers: { 
                "Content-Type": "application/json",
                "Authorization": `Bearer ${usuario.token}` 
            },
            body: JSON.stringify({ id_partida: partidaGuardada.id })
        });

        if (response.ok) {
            showAlert("❌ Has abandonado la partida.", "warning");
            localStorage.removeItem("partida"); 
            tableroContainer.innerHTML = ""; 
            nuevaPartidaBtn.disabled = false;
        } else {
            showAlert("⚠️ No se pudo abandonar la partida.", "danger");
        }
    } catch (error) {
        showAlert("❌ Error en la conexión con el servidor.", "danger");
    }
};

if (abandonarPartidaBtn) {
    abandonarPartidaBtn.addEventListener("click", abandonarPartida);
}
