import { apiUrl } from "./game";

document.addEventListener("DOMContentLoaded", async () => {
    const usuario = JSON.parse(localStorage.getItem('usuario'));
    const historialContainer = document.getElementById("historialContainer");
    const paginationContainer = document.getElementById("pagination");

    try {
        const response = await fetch(`${apiUrl}/partidas/jugador/${usuario.id}`, {
            method: "GET",
            headers: { 
                "Content-Type": "application/json",
                "Authorization": `Bearer ${usuario.token}` 
            }
        });

        const data = await response.json();

        if (response.ok) {
            if (data.length === 0) {
                historialContainer.innerHTML = `<div class="alert alert-info">❕No hay historial disponible para mostrar.</div>`;
            } else {
                renderTable(data);
            }
        } else {
            console.error("Error al obtener el historial");
        }
    } catch (error) {
        console.error("Error de conexión:", error);
    }

    function renderTable(partidas) {
        let currentPage = 1;
        const rowsPerPage = 5;
        
        function displayTablePage(page) {
            const start = (page - 1) * rowsPerPage;
            const end = start + rowsPerPage;
            const partidasToDisplay = partidas.slice(start, end);

            let tableHTML = `
                <table class="table table-striped table-bordered">
                    <thead class="custom-table-header">
                        <tr>
                            <th># Partida</th>
                            <th>Estado</th>
                            <th>Ganador</th>
                        </tr>
                    </thead>
                    <tbody>
            `;

            partidasToDisplay.forEach((partida, index) => {
                tableHTML += `
                    <tr>
                        <td>${start + index + 1}</td>
                        <td>${partida.estado}</td>
                        <td>${partida.ganador || "❌ Sin ganador"}</td>
                    </tr>
                `;
            });

            tableHTML += `</tbody></table>`;
            historialContainer.innerHTML = tableHTML;
            renderPagination();
        }

        function renderPagination() {
            const totalPages = Math.ceil(partidas.length / rowsPerPage);
            let paginationHTML = `<nav><ul class="pagination justify-content-center">`;

            for (let i = 1; i <= totalPages; i++) {
                paginationHTML += `
                    <li class="page-item ${i === currentPage ? "active custom-active-page" : ""}">
                        <button class="page-link custom-page-link" data-page="${i}">${i}</button>
                    </li>
                `;
            }

            paginationHTML += `</ul></nav>`;
            paginationContainer.innerHTML = paginationHTML;

            document.querySelectorAll(".page-link").forEach(button => {
                button.addEventListener("click", (e) => {
                    currentPage = parseInt(e.target.getAttribute("data-page"));
                    displayTablePage(currentPage);
                });
            });
        }

        displayTablePage(currentPage);
    }
});
