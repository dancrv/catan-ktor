package com.modelo

import kotlinx.serialization.Serializable

@Serializable
data class Respuesta(val msg: String, val status: Int)
