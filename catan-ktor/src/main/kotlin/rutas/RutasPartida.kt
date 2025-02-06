package com.rutas

import com.DAO.PartidaDAO
import com.DAO.UsuarioDAO
import com.modelo.Respuesta
import io.ktor.http.*
import io.ktor.server.auth.*
import io.ktor.server.request.*
import io.ktor.server.response.*
import io.ktor.server.routing.*

fun Route.partidaRouting() {
    val partidaDAO = PartidaDAO()
    val usuarioDAO = UsuarioDAO()

    route("/crearPartida") {
        authenticate {
            post {
                val params = call.receive<Map<String, Int>>()
                val idJugador = params["id_jugador"]
                val jugador = usuarioDAO.obtenerUsuario(idJugador)
                if (jugador == null) {
                    return@post call.respond(
                        HttpStatusCode.NotFound, Respuesta("El jugador no existe", HttpStatusCode.NotFound.value)
                    )
                }

                val nuevaPartida = partidaDAO.crearPartida(idJugador)
                if (nuevaPartida != null) {
                    call.respond(HttpStatusCode.OK, nuevaPartida)
                } else {
                    call.respond(
                        HttpStatusCode.InternalServerError, Respuesta("No se pudo crear la partida", HttpStatusCode.InternalServerError.value)
                    )
                }
            }
        }
    }

    route("/partidas") {
        authenticate {
            get {
                val partidas = partidaDAO.obtenerPartidas()
                if (partidas.isNotEmpty()) {
                    return@get call.respond(HttpStatusCode.OK, partidas)
                } else {
                    return@get call.respond(
                        HttpStatusCode.OK,
                        Respuesta("No hay partidas", HttpStatusCode.OK.value)
                    )
                }
            }

            get("/{id}") {
                val id = call.parameters["id"] ?: return@get call.respond(
                    HttpStatusCode.NotFound,
                    Respuesta("Falta el id en la url", HttpStatusCode.NotFound.value)
                )
                val idPartida = id.toInt()
                val partida = partidaDAO.obtenerPartida(idPartida)
                if (partida == null) {
                    return@get call.respond(
                        HttpStatusCode.NotFound,
                        Respuesta("Partida no encontrada", HttpStatusCode.NotFound.value)
                    )
                }
                call.respond(HttpStatusCode.OK, partida)
            }
        }
    }
}