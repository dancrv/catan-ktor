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
                return Partida(
                    id = idPartida,
                    idJugador = idJugador,
                    estado = "EN_CURSO",
                    tablero = tablero,
                    turno = "JUGADOR"
                )
            }
        }
        return null
    }

    private fun inicializarTablero(idPartida: Int): List<Casilla> {
        val recursos = Recurso.entries
        val tablero = mutableListOf<Casilla>()
        val sqlCasilla = "INSERT INTO casillas (id_partida, recurso, valor_dado, propietario) VALUES (?, ?, ?, ?)"
        val connection = Conexion.getConnection()
        connection?.use { conn ->
            val statement = conn.prepareStatement(sqlCasilla, Statement.RETURN_GENERATED_KEYS)
            for (fila in 1..3) {
                for (columna in 1..4) {
                    val recursoAleatorio = recursos.random()
                    val valorDado = Random.nextInt(1, 7)
                    statement.setInt(1, idPartida)
                    statement.setString(2, recursoAleatorio.name)
                    statement.setInt(3, valorDado)
                    statement.setString(4, "LIBRE")
                    statement.executeUpdate()
                    val generatedKeys = statement.generatedKeys
                    var idCasilla: Int? = null
                    if (generatedKeys.next()) {
                        idCasilla = generatedKeys.getInt(1)
                    }
                    tablero.add(
                        Casilla(
                            id = idCasilla,
                            idPartida = idPartida,
                            recurso = recursoAleatorio,
                            valorDado = valorDado,
                            propietario = "LIBRE"
                        )
                    )
                }
            }
        }
        return tablero
    }


    fun obtenerTableroDePartida(idPartida: Int): List<Casilla> {
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

    fun modificarEstadoPartida(idPartida: Int, nuevoEstado: String): Boolean {
        val sql = "UPDATE partidas SET estado = ? WHERE id = ?"
        val connection = Conexion.getConnection()
        connection?.use {
            val statement = it.prepareStatement(sql)
            statement.setString(1, nuevoEstado)
            statement.setInt(2, idPartida)

            return statement.executeUpdate() > 0
        }
        return false
    }

    fun seleccionarCasilla(idCasilla: Int, nuevoPropietario: String): Boolean {
        val sql = "UPDATE casillas SET propietario = ? WHERE id = ? AND propietario = 'LIBRE'"
        val connection = Conexion.getConnection()
        connection?.use {
            val statement = it.prepareStatement(sql)
            statement.setString(1, nuevoPropietario)
            statement.setInt(2, idCasilla)
            return statement.executeUpdate() > 0
        }
        return false
    }

    fun seleccionarCasillaParaServidor(idPartida: Int): Boolean {
        val casillasLibres = obtenerTableroDePartida(idPartida).filter { it.propietario == "LIBRE" }
        if (casillasLibres.isEmpty()) {
            return false
        }

        val pesos = mapOf(
            "MADERA" to 1.0,
            "TRIGO" to 1.5,
            "CARBON" to 1.2
        )

        val casillaSeleccionada = casillasLibres.maxByOrNull { casilla ->
            val peso = pesos[casilla.recurso.name] ?: 1.0
            casilla.valorDado * peso
        } ?: return false

        val sql = "UPDATE casillas SET propietario = ? WHERE id = ? AND propietario = 'LIBRE'"
        val connection = Conexion.getConnection()
        connection?.use {
            val statement = it.prepareStatement(sql)
            statement.setString(1, "SERVIDOR")
            statement.setInt(2, casillaSeleccionada.id!!)
            return statement.executeUpdate() > 0
        }
        return false
    }
}