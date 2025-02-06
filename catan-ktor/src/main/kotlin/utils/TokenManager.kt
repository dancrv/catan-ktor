package com.utils

import com.auth0.jwt.JWT
import com.auth0.jwt.JWTVerifier
import com.auth0.jwt.algorithms.Algorithm
import com.auth0.jwt.algorithms.Algorithm.HMAC256
import com.modelo.Usuario

class TokenManager {

    var secret = Parametros.secret
    var issuer = Parametros.issuer
    var audience = Parametros.audience

    fun generateJWTToken(usuario: Usuario):String{
        val token = JWT.create()
            .withAudience(audience)
            .withIssuer(issuer)
            .withClaim("email", usuario.email)
            .sign(Algorithm.HMAC256(secret))

        return token
    }

    fun verifyJWTToken() : JWTVerifier {
        return JWT.require(HMAC256(secret))
            .withAudience(audience)
            .withIssuer(issuer)
            .build()
    }
}