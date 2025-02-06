package com.DAO

import com.modelo.Casilla
import com.modelo.Partida
import com.modelo.Recurso
import java.sql.Statement
import kotlin.random.Random

class PartidaDAO {

    fun crearPartida(idJugador: Int?): Partida? {
        val sqlPartida = "INSERT INTO partidas (id_jugador, estado, turno) VALUES (?, ?, ?)"
        val connection = Conexion.getConnection()
        connection?.use {
            val statement = it.prepareStatement(sqlPartida, Statement.RETURN_GENERATED_KEYS)
            statement.setInt(1, idJugador!!)
            statement.setString(2, "EN_CURSO")
            statement.setString(3, "JUGADOR")

            val filasAfectadas = statement.executeUpdate()
            if (filasAfectadas == 0) return null

            val generatedKeys = statement.generatedKeys
            if (generatedKeys.next()) {
                val idPartida = generatedKeys.getInt(1)
                val tablero = inicializarTablero(idPartida)
                return Partida(id = idPartida, idJugador = idJugador, estado = "EN_CURSO", tablero = tablero, turno = "JUGADOR")
            }
        }
        return null
    }

    private fun inicializarTablero(idPartida: Int): List<Casilla> {
        val recursos = Recurso.entries // Enum con los recursos
        val tablero = mutableListOf<Casilla>()
        val sqlCasilla = "INSERT INTO casillas (id_partida, recurso, valor_dado, propietario) VALUES (?, ?, ?, ?)"
        val connection = Conexion.getConnection()
        connection?.use {
            val statement = it.prepareStatement(sqlCasilla, Statement.RETURN_GENERATED_KEYS)
            for (fila in 1..3) {
                for (columna in 1..4) {
                    val recursoAleatorio = recursos.random()
                    val valorDado = Random.nextInt(1, 7) // Valores de 1 a 6
                    statement.setInt(1, idPartida)
                    statement.setString(2, recursoAleatorio.name)
                    statement.setInt(3, valorDado)
                    statement.setString(4, "LIBRE")
                    statement.addBatch()
                    tablero.add(Casilla(id = null, idPartida = idPartida, recurso = recursoAleatorio, valorDado = valorDado, propietario = "LIBRE"))
                }
            }
            statement.executeBatch()
        }
        return tablero
    }

    private fun obtenerTableroDePartida(idPartida: Int): List<Casilla> {
        val casillas = mutableListOf<Casilla>()
        val sql = "SELECT * FROM casillas WHERE id_partida = ?"
        val connection = Conexion.getConnection()
        connection?.use {
            val statement = it.prepareStatement(sql)
            statement.setInt(1, idPartida)
            val resultSet = statement.executeQuery()

            while (resultSet.next()) {
                casillas.add(
                    Casilla(
                        id = resultSet.getInt("id"),
                        idPartida = idPartida,
                        recurso = Recurso.valueOf(resultSet.getString("recurso")),
                        valorDado = resultSet.getInt("valor_dado"),
                        propietario = resultSet.getString("propietario")
                    )
                )
            }
        }
        return casillas
    }

    fun obtenerPartidas(): List<Partida> {
        val partidas = mutableListOf<Partida>()
        val sql = "SELECT * FROM partidas"
        val connection = Conexion.getConnection()
        connection?.use {
            val statement = it.prepareStatement(sql)
            val resultSet = statement.executeQuery()

            while (resultSet.next()) {
                val idPartida = resultSet.getInt("id")
                val idJugador = resultSet.getInt("id_jugador")
                val estado = resultSet.getString("estado")
                val turno = resultSet.getString("turno")
                val tablero = obtenerTableroDePartida(idPartida)

                partidas.add(Partida(idPartida, idJugador, estado, tablero, turno))
            }
        }
        return partidas
    }

    fun obtenerPartida(id: Int): Partida? {
        val sql = "SELECT * FROM partidas WHERE id = ?"
        val connection = Conexion.getConnection()
        connection?.use {
            val statement = it.prepareStatement(sql)
            statement.setInt(1, id)
            val resultSet = statement.executeQuery()

            while (resultSet.next()) {
                val idPartida = resultSet.getInt("id")
                val idJugador = resultSet.getInt("id_jugador")
                val estado = resultSet.getString("estado")
                val turno = resultSet.getString("turno")
                val tablero = obtenerTableroDePartida(idPartida)

                return Partida(idPartida, idJugador, estado, tablero, turno)
            }
        }
        return null
    }
}