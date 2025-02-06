package com.modelo

import kotlinx.serialization.Serializable

@Serializable
data class Casilla(
    val id: Int? = null,
    val idPartida: Int,
    val recurso: Recurso,
    val valorDado: Int,
    val propietario: String // "JUGADOR", "SERVIDOR", "LIBRE"
)
