package com.utils

import at.favre.lib.crypto.bcrypt.BCrypt

object Seguridad {
    fun encriptarPass(pass: String): String {
        return BCrypt.withDefaults().hashToString(12, pass.toCharArray())
    }

    fun verificarPass(passwordIngresada: String, passwordHashAlmacenada: String): Boolean {
        return BCrypt.verifyer().verify(passwordIngresada.toCharArray(), passwordHashAlmacenada).verified
    }
}