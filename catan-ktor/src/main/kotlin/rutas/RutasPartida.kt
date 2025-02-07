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

            post("/seleccionarCasilla") {

                val params = call.receive<Map<String, Int>>()
                val idPartida = params["id_partida"] ?: return@post call.respond(
                    HttpStatusCode.BadRequest,
                    Respuesta("Falta el id de la partida", HttpStatusCode.BadRequest.value)
                )
                val idCasilla = params["id_casilla"] ?: return@post call.respond(
                    HttpStatusCode.BadRequest,
                    Respuesta("Falta el id de la casilla", HttpStatusCode.BadRequest.value)
                )

                val partida = partidaDAO.obtenerPartida(idPartida)
                if (partida == null) {
                    return@post call.respond(
                        HttpStatusCode.NotFound,
                        Respuesta("Partida no encontrada", HttpStatusCode.NotFound.value)
                    )
                }

                if (partida.turno != "JUGADOR") {
                    return@post call.respond(
                        HttpStatusCode.BadRequest,
                        Respuesta("No es el turno del jugador", HttpStatusCode.BadRequest.value)
                    )
                }

                if (partida.estado != "EN_CURSO") {
                    return@post call.respond(
                        HttpStatusCode.BadRequest,
                        Respuesta("La partida ya no está activa", HttpStatusCode.BadRequest.value)
                    )
                }

                val exito = partidaDAO.seleccionarCasilla(idCasilla, "JUGADOR")
                if (!exito) {
                    return@post call.respond(
                        HttpStatusCode.BadRequest,
                        Respuesta("La casilla no se pudo actualizar o ya está ocupada", HttpStatusCode.BadRequest.value)
                    )
                }

                val tablero = partidaDAO.obtenerTableroDePartida(idPartida)
                if (tablero.any { it.propietario == "LIBRE" }) {
                    val exitoServidor = partidaDAO.seleccionarCasillaParaServidor(idPartida)
                    if (!exitoServidor) {
                        return@post call.respond(
                            HttpStatusCode.InternalServerError,
                            Respuesta("No se pudo seleccionar la casilla para el servidor", HttpStatusCode.InternalServerError.value)
                        )
                    }
                }

                val partidaActualizada = partidaDAO.obtenerPartida(idPartida)
                if (partidaActualizada == null) {
                    return@post call.respond(
                        HttpStatusCode.InternalServerError,
                        Respuesta("Error al obtener la partida actualizada", HttpStatusCode.InternalServerError.value)
                    )
                }

                call.respond(HttpStatusCode.OK, partidaActualizada)
            }


            post("/abandonar") {
                val params = call.receive<Map<String, Int>>()
                val id = params["id_partida"] ?: return@post call.respond(
                    HttpStatusCode.NotFound,
                    Respuesta("Falta el id de la partida", HttpStatusCode.NotFound.value)
                )
                val idPartida = id.toInt()
                val partida = partidaDAO.obtenerPartida(idPartida)
                if (partida == null) {
                    return@post call.respond(
                        HttpStatusCode.NotFound,
                        Respuesta("Partida no encontrada", HttpStatusCode.NotFound.value)
                    )
                }
                val exito = partidaDAO.modificarEstadoPartida(idPartida, "ABANDONADA")

                if (exito) {
                    call.respond(
                        HttpStatusCode.OK,
                        Respuesta("Partida abandonada correctamente", HttpStatusCode.OK.value)
                    )
                } else {
                    call.respond(
                        HttpStatusCode.InternalServerError,
                        Respuesta("No se pudo actualizar el estado de la partida", HttpStatusCode.InternalServerError.value)
                    )
                }
            }
        }
    }
}