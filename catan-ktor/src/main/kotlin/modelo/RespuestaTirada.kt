package com.modelo

import kotlinx.serialization.Serializable

@Serializable
data class RespuestaTirada(
    val dado: Int,
    val partida: Partida,
    val almacenJugador: AlmacenRecursos?,
    val almacenServidor: AlmacenRecursosServidor,
    val ganador: String? = null
)
