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
        "MADERA": { imagen: "/img/forest.png", emoji: "🌲" },
        "TRIGO": { imagen: "/img/field.png", emoji: "🌾" },
        "CARBON": { imagen: "/img/mountain.png", emoji: "⛏️" }
    };

    let html = `
        <div class="tablero-grid">
    `;

    tablero.forEach(casilla => {
        const recurso = recursos[casilla.recurso] || { imagen: "img/default.png", emoji: "❓" };

        let borde = "none";
        if (casilla.propietario === "JUGADOR") borde = "2px solid green";
        if (casilla.propietario === "SERVIDOR") borde = "2px solid #8f1d27";

       html += `
            <div class="casilla" style="
                background-image: url('${recurso.imagen}');
                background-size: cover;
                border: ${borde};
                display: flex;
                align-items: center;
                justify-content: center;
                font-size: 2rem;
                font-weight: bold;
                width: 150px;
                height: 150px;
                margin: 5px;
                color: white;
                text-shadow: 2px 2px 4px rgba(0, 0, 0, 0.6);
            ">
                <div class="recurso rounded-5">
                    <p class="m-0">${casilla.recurso}</p>
                    <p class="m-0">${casilla.valorDado}</p>
                    <p class="m-0">${recurso.emoji}</p>
                </div>
            </div>
        `;
    });

    html += '</div>';
    tableroContainer.innerHTML = html;
};


if (nuevaPartidaBtn) {
    nuevaPartidaBtn.addEventListener("click", crearPartida);
}

document.addEventListener("DOMContentLoaded", () => {
    const partidaGuardada = JSON.parse(localStorage.getItem("partida"));

    if (partidaGuardada) {
        showAlert("⏳ Continuando partida en progreso...", 'info');
        pintarTablero(partidaGuardada.tablero);
        
        if (partidaGuardada && partidaGuardada.estado === "EN_JUEGO") {
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