# 🎲 Conquistadores de Catán 🏰

¡Bienvenido a **Conquistadores de Catán**! Una versión simplificada del famoso juego de estrategia, diseñada como un trabajo de clase con **Ktor (backend) y JavaScript (frontend)**. ¡Pon a prueba tu suerte y estrategia contra el servidor!

## 🛠️ **Tecnologías Utilizadas**

-   🔹 **Backend:** [Ktor](https://ktor.io) (Kotlin)
-   🔹 **Frontend:** HTML, CSS, JavaScript, Bootstrap
-   🔹 **Autenticación:** JWT (JSON Web Tokens)
-   🔹 **Almacenamiento:** Base de datos MySQL

## 🚀 **Instalación y Ejecución**

### 🖥️ **Backend (Ktor)**

1.  Abre el proyecto del backend en tu IDE.
2. Crea una base de datos MySQL.
3. Modifica según tu necesidad los parámetros `bbdd`,  `usuario` y `pass` del archivo `Parametros` localizado en `\src\main\kotlin\utils`.
4.  Ejecuta la aplicación Ktor.

### 🎨 **Front-end (catan-front)**
1. Accede a la carpeta del front-end:
```bash
   cd catan-front
   ```
2. Instala las dependencias de Node.js:
```bash
   npm install
   ```
3. Inicia la aplicación:
```bash
   npm run dev
```
4. La aplicación se ejecutará en:  
🔗 **http://localhost:5173**

## 🔑 **Credenciales de Prueba**

Para iniciar sesión en el juego, usa las siguientes credenciales:

-   **Email:** `dan@catan.com`
-   **Contraseña:** `12345`

También puedes registrar tus propios usuarios.

## 🎮 **Cómo Jugar**

### 🎯 **Objetivo del Juego**

Gana el primer jugador que alcance **20 unidades de madera, trigo y carbón** en su almacén.

### 👥 **Jugadores**

-   🧑 **Jugador Humano** (tú).
-   🤖 **Servidor** (el ordenador).

### 🌍 **Tablero de Juego**

-   Se juega en un tablero de **3x4 casillas** (12 en total).
-   Cada casilla tiene:
    -   Un recurso: 🌲 **Madera**, 🌾 **Trigo**, ⛏️ **Carbón**.
    -   Un número del **1 al 6** (asignado al azar).
    -   Un propietario (Jugador Humano o Servidor).

### 🔄 **Desarrollo del Juego**

1.  Al inicio, el jugador y el servidor eligen casillas **hasta que todas estén ocupadas**.
2.  En cada turno, se **lanza un dado**.
3.  Si el número del dado coincide con el de una casilla, **su dueño recibe el recurso** de esa casilla.
4.  Gana el primer jugador en **alcanzar 20 unidades de cada recurso**.
5.  El jugador puede **abandonar en cualquier momento** o **guardar la partida** y continuar después.

---

### 📝 Licencia

Este proyecto está bajo la licencia **MIT**. Puedes consultar más detalles en el archivo `LICENSE`.
