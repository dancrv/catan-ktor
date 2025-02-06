package com.modelo

import kotlinx.serialization.Serializable

@Serializable
data class Usuario(val id: Int, val email: String, val password: String)
