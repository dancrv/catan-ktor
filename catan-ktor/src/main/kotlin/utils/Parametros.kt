package com.utils

object Parametros {
    val ip = "127.0.0.1"
    val port = 8080
    val secret = "m1p@L@Br@S3cReT@!"
    val issuer = "http://$ip:$port"
    val audience = "http://$ip:$port/catan"
    val realm = "Access to 'catan'"

    val puertobd = 3306
    var bbdd = "catan"
    var usuario = "dancrv"
    var pass = "Marvel2025"
}