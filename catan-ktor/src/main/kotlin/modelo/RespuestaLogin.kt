package com.modelo

import kotlinx.serialization.Serializable

@Serializable
data class RespuestaLogin(val id: Int, val email: String, val token: String)
