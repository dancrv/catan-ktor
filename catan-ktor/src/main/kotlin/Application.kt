package com

import com.utils.Parametros
import com.utils.TokenManager
import io.ktor.server.application.*
import io.ktor.server.auth.*
import io.ktor.server.auth.jwt.*
import io.ktor.server.engine.*
import io.ktor.server.netty.*
import io.ktor.server.plugins.cors.routing.*
import io.ktor.http.*

fun main() {
    embeddedServer(Netty, port = Parametros.port, host = Parametros.ip, module = Application::module)
        .start(wait = true)
}

fun Application.configureCORS() {
    install(CORS) {
        anyHost()
        allowHeader(HttpHeaders.ContentType)
        allowHeader(HttpHeaders.Authorization)
        allowMethod(HttpMethod.Get)
        allowMethod(HttpMethod.Post)
        allowMethod(HttpMethod.Put)
        allowMethod(HttpMethod.Delete)
    }
}

fun Application.module() {
    val tokenManager = TokenManager()
    configureSerialization()

    install(Authentication) {

        jwt {
            verifier(tokenManager.verifyJWTToken())
            realm = Parametros.realm
            validate {
                if (it.payload.getClaim("email").asString().isNotEmpty()) {
                    JWTPrincipal(it.payload)
                }
                else {
                    null
                }
            }
        }
    }

    configureRouting()
    configureCORS()
}
