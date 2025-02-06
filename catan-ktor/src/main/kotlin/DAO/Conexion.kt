package com.DAO

import com.utils.Parametros
import java.sql.Connection
import java.sql.DriverManager
import java.sql.SQLException

object Conexion {
    private val url = "jdbc:mysql://localhost:" + Parametros.puertobd + "/" + Parametros.bbdd
    private val user = Parametros.usuario
    private val password = Parametros.pass

    fun getConnection(): Connection? {
        return try {
            DriverManager.getConnection(url, user, password)
        } catch (e: SQLException) {
            e.printStackTrace()
            null
        }
    }
}