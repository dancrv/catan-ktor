package com.modelo

import kotlinx.serialization.Serializable

@Serializable
data class Partida(
    val id: Int? = null,
    val idJugador: Int,
    val estado: String, // "EN_CURSO", "FINALIZADA", "ABANDONADA"
    val tablero: List<Casilla> = emptyList(),
    val tableroLleno: Boolean,
    val ganador: String? = null
)
