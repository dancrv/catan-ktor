package com.modelo

import kotlinx.serialization.Serializable

@Serializable
data class RespuestaTirada(
    val dado: Int,
    val partida: Partida,
    val almacenJugador: AlmacenRecursos?,
    val almacenServidor: AlmacenRecursosServidor, // O el tipo que uses en memoria para el servidor
    val ganador: String? = null
)
