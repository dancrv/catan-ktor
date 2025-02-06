package com.modelo

import kotlinx.serialization.Serializable

@Serializable
data class AlmacenRecursos(
    val idJugador: Int,
    val madera: Int = 0,
    val trigo: Int = 0,
    val carbon: Int = 0
)
