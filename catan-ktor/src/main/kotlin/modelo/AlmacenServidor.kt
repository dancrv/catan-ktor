package com.modelo

import kotlinx.serialization.Serializable

object AlmacenServidor {

    private val almacenes: MutableMap<Int, AlmacenRecursosServidor> = mutableMapOf()

    fun inicializarAlmacen(idPartida: Int) {
        almacenes[idPartida] = AlmacenRecursosServidor(madera = 0, trigo = 0, carbon = 0)
    }

    fun actualizarRecurso(idPartida: Int, recurso: Recurso, cantidad: Int) {
        val almacen = almacenes[idPartida] ?: return
        when (recurso) {
            Recurso.MADERA -> almacen.madera += cantidad
            Recurso.TRIGO -> almacen.trigo += cantidad
            Recurso.CARBON -> almacen.carbon += cantidad
        }
    }

    fun obtenerAlmacen(idPartida: Int): AlmacenRecursosServidor? {
        return almacenes[idPartida]
    }
}

@Serializable
data class AlmacenRecursosServidor(
    var madera: Int,
    var trigo: Int,
    var carbon: Int
)