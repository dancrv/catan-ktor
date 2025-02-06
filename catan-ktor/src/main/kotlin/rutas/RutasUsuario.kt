package com.rutas

import com.DAO.UsuarioDAO
import com.modelo.Respuesta
import com.modelo.RespuestaLogin
import com.modelo.UsuarioLogin
import com.utils.TokenManager
import io.ktor.http.*
import io.ktor.server.auth.*
import io.ktor.server.request.*
import io.ktor.server.response.*
import io.ktor.server.routing.*

fun Route.userRouting() {
    val usuarioDAO = UsuarioDAO()
    val tokenManager = TokenManager()

    route("/registrar") {
        post {
            val usuario = call.receive<UsuarioLogin>()

            if (usuario.email.isBlank() || usuario.password.isBlank()) {
                return@post call.respond(
                    HttpStatusCode.BadRequest,
                    Respuesta("⚠️ El email y la contraseña son obligatorios.", HttpStatusCode.BadRequest.value)
                )
            }

            if (usuarioDAO.registrar(usuario)) {
                return@post call.respond(
                    HttpStatusCode.Created,
                    Respuesta("Usuario ${usuario.email} registrado.", HttpStatusCode.Created.value))

            } else {
                return@post call.respond(
                    HttpStatusCode.Conflict,
                    Respuesta("Usuario ${usuario.email} no registrado.", HttpStatusCode.Conflict.value))
            }
        }
    }

    route("/login") {
        post {
            val user = call.receive<UsuarioLogin>()
            val usuario = usuarioDAO.login(user)

            if (usuario == null) {
                return@post call.respond(
                    HttpStatusCode.NotFound,
                    Respuesta("Credenciales incorrectas.", HttpStatusCode.NotFound.value))
            }
            val token = tokenManager.generateJWTToken(usuario)
            val respuesta = RespuestaLogin(usuario.id, usuario.email, token)

            call.respond(HttpStatusCode.OK, respuesta)
        }
    }

    route("/listado") {
        authenticate {
            get {
                val usuarios = usuarioDAO.obtenerUsuarios()
                if (usuarios.isNotEmpty()) {
                    return@get call.respond(HttpStatusCode.OK, usuarios)
                } else {
                    return@get call.respond(
                        HttpStatusCode.OK,
                        Respuesta("No hay usuarios.", HttpStatusCode.OK.value))
                }
            }

            get("/{id}") {
                val id = call.parameters["id"] ?: return@get call.respond(
                    HttpStatusCode.NotFound,
                    Respuesta("Falta el id en la url", HttpStatusCode.NotFound.value)
                )
                val idUsuario = id.toInt()
                val usuario = usuarioDAO.obtenerUsuario(idUsuario)
                if (usuario == null) {
                    return@get call.respond(
                        HttpStatusCode.NotFound,
                        Respuesta("Usuario no encontrado", HttpStatusCode.NotFound.value)
                    )
                }
                call.respond(HttpStatusCode.OK, usuario)
            }
        }
    }
}