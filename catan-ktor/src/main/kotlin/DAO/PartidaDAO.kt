package com.DAO

import com.modelo.*
import java.sql.Statement
import kotlin.random.Random

class PartidaDAO {

    fun crearPartida(idJugador: Int?): Partida? {
        val sqlPartida = "INSERT INTO partidas (id_jugador, estado) VALUES (?, ?)"
        val connection = Conexion.getConnection()
        connection?.use {
            val statement = it.prepareStatement(sqlPartida, Statement.RETURN_GENERATED_KEYS)
            statement.setInt(1, idJugador!!)
            statement.setString(2, "EN_CURSO")

            val filasAfectadas = statement.executeUpdate()
            if (filasAfectadas == 0) return null

            val generatedKeys = statement.generatedKeys
            if (generatedKeys.next()) {
                val idPartida = generatedKeys.getInt(1)
                val tablero = inicializarTablero(idPartida)
                val nuevaPartida =  Partida(
                    id = idPartida,
                    idJugador = idJugador,
                    estado = "EN_CURSO",
                    tablero = tablero,
                    tableroLleno = false
                )
                AlmacenServidor.inicializarAlmacen(nuevaPartida.id!!)
                crearAlmacen(idJugador)
                return nuevaPartida
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
                val tablero = obtenerTableroDePartida(idPartida)
                val tableroLleno = tablero.none { it.propietario == "LIBRE" }
                val ganador = resultSet.getString("ganador")

                partidas.add(Partida(idPartida, idJugador, estado, tablero, tableroLleno, ganador))
            }
        }
        return partidas
    }

    fun obtenerPartidasDeJugador(idJugador: Int): List<Partida> {
        val partidas = mutableListOf<Partida>()
        val sql = "SELECT * FROM partidas WHERE id_jugador = ?"
        val connection = Conexion.getConnection()
        connection?.use {
            val statement = it.prepareStatement(sql)
            statement.setInt(1, idJugador)
            val resultSet = statement.executeQuery()

            while (resultSet.next()) {
                val idPartida = resultSet.getInt("id")
                val idJugador = resultSet.getInt("id_jugador")
                val estado = resultSet.getString("estado")
                val tablero = obtenerTableroDePartida(idPartida)
                val tableroLleno = tablero.none { it.propietario == "LIBRE" }
                val ganador = resultSet.getString("ganador")

                partidas.add(Partida(idPartida, idJugador, estado, tablero, tableroLleno, ganador))
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
                val tablero = obtenerTableroDePartida(idPartida)
                val tableroLleno = tablero.none { it.propietario == "LIBRE" }
                val ganador = resultSet.getString("ganador")

                return Partida(idPartida, idJugador, estado, tablero, tableroLleno, ganador)
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

    fun modificarGanadorPartida(idPartida: Int, ganador: String): Boolean {
        val sql = "UPDATE partidas SET ganador = ? WHERE id = ?"
        val connection = Conexion.getConnection()
        connection?.use {
            val statement = it.prepareStatement(sql)
            statement.setString(1, ganador)
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

    fun actualizarRecurso(idJugador: Int, recurso: Recurso, cantidad: Int): Boolean {

        val sql = when (recurso) {
            Recurso.MADERA -> "UPDATE almacenrecursos SET madera = madera + ? WHERE id_jugador = ?"
            Recurso.TRIGO -> "UPDATE almacenrecursos SET trigo = trigo + ? WHERE id_jugador = ?"
            Recurso.CARBON -> "UPDATE almacenrecursos SET carbon = carbon + ? WHERE id_jugador = ?"
        }
        val connection = Conexion.getConnection()
        connection?.use {
            val statement = it.prepareStatement(sql)
            statement.setInt(1, cantidad)
            statement.setInt(2, idJugador)
            return statement.executeUpdate() > 0
        }
        return false
    }

    fun obtenerAlmacen(idJugador: Int): AlmacenRecursos? {
        val sql = "SELECT * FROM almacenrecursos WHERE id_jugador = ? ORDER BY id DESC LIMIT 1"
        val connection = Conexion.getConnection()
        connection?.use {
            val statement = it.prepareStatement(sql)
            statement.setInt(1, idJugador)
            val rs = statement.executeQuery()
            if (rs.next()) {
                return AlmacenRecursos(
                    id = rs.getInt("id"),
                    idJugador = idJugador,
                    madera = rs.getInt("madera"),
                    trigo = rs.getInt("trigo"),
                    carbon = rs.getInt("carbon")
                )
            }
        }
        return null
    }


    fun crearAlmacen(idJugador: Int) {
        val sql = "INSERT INTO almacenrecursos (id_jugador, madera, trigo, carbon) VALUES (?, 0, 0, 0)"
        val connection = Conexion.getConnection()
        connection?.use {
            val statement = it.prepareStatement(sql)
            statement.setInt(1, idJugador)
            statement.executeUpdate()
        }
    }

    fun tirarDado(idPartida: Int): RespuestaTirada? {
        val partida = obtenerPartida(idPartida) ?: return null
        if (partida.estado != "EN_CURSO") return null

        val dado = Random.nextInt(1, 7)
        val tablero = obtenerTableroDePartida(idPartida)

        tablero.forEach { casilla ->
            if (casilla.valorDado == dado && casilla.propietario != "LIBRE") {
                if (casilla.propietario == "JUGADOR") {
                    actualizarRecurso(partida.idJugador, casilla.recurso, dado)

                } else if (casilla.propietario == "SERVIDOR") {

                    AlmacenServidor.actualizarRecurso(idPartida, casilla.recurso, dado)
                }
            }
        }

        val almacenServidor = AlmacenServidor.obtenerAlmacen(idPartida)
            ?: run {
                AlmacenServidor.inicializarAlmacen(idPartida)
                AlmacenServidor.obtenerAlmacen(idPartida)
            }

        val idJugador = partida.idJugador
        val almacenJugador = obtenerAlmacen(idJugador)
        var ganador: String? = null

        obtenerPartida(idPartida)

        if (jugadorGana(idPartida,idJugador)) {
            ganador = "JUGADOR"
        } else if (servidorGana(idPartida)) {
            ganador = "SERVIDOR"
        }

        val partidaActualizada = obtenerPartida(idPartida)

        return RespuestaTirada(
            dado = dado,
            partida = partidaActualizada!!,
            almacenJugador = almacenJugador,
            almacenServidor = almacenServidor!!,
            ganador = ganador
        )
    }

    fun jugadorGana(idPartida: Int, idJugador: Int): Boolean {
        val sql = "SELECT * FROM almacenrecursos WHERE id_jugador = ? ORDER BY id DESC LIMIT 1"
        val connection = Conexion.getConnection()

        connection?.use {
            val statement = it.prepareStatement(sql)
            statement.setInt(1, idJugador)
            val resultSet = statement.executeQuery()

            if (resultSet.next()) {
                val madera = resultSet.getInt("madera")
                val trigo = resultSet.getInt("trigo")
                val carbon = resultSet.getInt("carbon")

                if (madera >= 20 && trigo >= 20 && carbon >= 20) {
                    modificarEstadoPartida(idPartida, "FINALIZADA")
                    modificarGanadorPartida(idPartida, "JUGADOR")
                    return true
                }
            }
        }
        return false
    }

    fun servidorGana(idPartida: Int): Boolean {
        val almacen = AlmacenServidor.obtenerAlmacen(idPartida) ?: return false

        if (almacen.madera >= 20 && almacen.trigo >= 20 && almacen.carbon >= 20) {
            modificarEstadoPartida(idPartida, "FINALIZADA")
            modificarGanadorPartida(idPartida, "SERVIDOR")
            return true
        }
        return false
    }

}