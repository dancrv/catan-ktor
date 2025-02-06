package com.DAO

import com.modelo.Usuario
import com.modelo.UsuarioLogin
import com.utils.Seguridad

class UsuarioDAO {

    fun registrar(usuario: UsuarioLogin): Boolean {
        val sql = "INSERT INTO usuarios (email, password) VALUES (?, ?)"
        val connection = Conexion.getConnection()

        connection?.use {
            val statement = it.prepareStatement(sql)
            val passEncriptada = Seguridad.encriptarPass(usuario.password)

            statement.setString(1, usuario.email)
            statement.setString(2, passEncriptada)

            return statement.executeUpdate() > 0

        }

        return false
    }

    fun login(usuario: UsuarioLogin): Usuario? {
        val sql = "SELECT * FROM usuarios WHERE email = ?"
        val connection = Conexion.getConnection()
        connection?.use {
            val statement = it.prepareStatement(sql)
            statement.setString(1, usuario.email)
            val resultSet = statement.executeQuery()

            if (resultSet.next()) {
                val passEncriptada = resultSet.getString("password")

                if (Seguridad.verificarPass(usuario.password, passEncriptada)) {
                    val id = resultSet.getInt("id")
                    val email = resultSet.getString("email")

                    return Usuario(
                        id = id,
                        email = email,
                        password = passEncriptada
                    )
                }
            }
        }
        return null
    }

    fun obtenerUsuarios(): List<Usuario> {
        val usuarios = mutableListOf<Usuario>()
        val sql = "SELECT * FROM usuarios"
        val connection = Conexion.getConnection()
        connection?.use {
            val statement = it.prepareStatement(sql)
            val resultSet = statement.executeQuery()

            while (resultSet.next()) {
                val usuario = Usuario(
                    id = resultSet.getInt("id"),
                    email = resultSet.getString("email"),
                    password = resultSet.getString("password")
                )
                usuarios.add(usuario)
            }
        }
        return usuarios
    }

    fun obtenerUsuario(id: Int?): Usuario? {
        val sql = "SELECT * FROM usuarios WHERE id = ?"
        val connection = Conexion.getConnection()
        connection?.use {
            val statement = it.prepareStatement(sql)
            statement.setInt(1, id!!)
            val resultSet = statement.executeQuery()

            while (resultSet.next()) {
                return Usuario (
                    id = resultSet.getInt("id"),
                    email = resultSet.getString("email"),
                    password = resultSet.getString("password")
                )
            }
        }
        return null
    }
}