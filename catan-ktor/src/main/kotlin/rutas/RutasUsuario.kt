package com.rutas

import com.DAO.UsuarioDAO
import com.modelo.Respuesta
import com.modelo.Usuario
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
            val usuario = call.receive<Usuario>()

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
            val user = call.receive<Usuario>()
            val usuario = usuarioDAO.login(user)

            if (usuario == null) {
                return@post call.respond(
                    HttpStatusCode.NotFound,
                    Respuesta("Credenciales incorrectas.", HttpStatusCode.NotFound.value))
            }
            val token = tokenManager.generateJWTToken(usuario)
            call.respond(mapOf("email" to usuario.email, "token" to token))
        }
    }

    route("/listado") {
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
    }
}