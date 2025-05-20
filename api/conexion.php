<?php
// Definimos el host del servidor MySQL
$host = "localhost";
/*$user = "asistencia";
$password = "asistencia2025";
$db = "asistencia";*/
//para el servidor
// Credenciales para el servidor (hosting real, contraseña y base de datos)
// Se utilizan para conectarse a la base de datos remota.
$user = "seismex1_asistencia";
$password = "i5YOUQC7S%lVñ";
$db = "seismex1_asistencia";
// Se crea una nueva instancia de conexión MySQL usando mysqli con los datos anteriores
$conn = new mysqli($host, $user, $password, $db);
// Se verifica si ocurrió algún error al hacer la conexión
if ($conn->connect_error) {
    // Si hay error, se imprime con var_dump lo que haya fallado
    var_dump("Conexion fallida: " . $conn->connect_error);
    // También se termina el script mostrando el mensaje de error
    die("Conexion fallida: " . $conn->connect_error);
} 
// else {
//     echo "Conexion exitosa. Ten un buen dia";
// }

// $connectionString = "mysql:hos=$host;dbname=$db;charset=utf8";
// try {
//     $conect = new PDO($connectionString, $user, $password);
//     $conect->setAttribute(PDO::ATTR_ERRMODE, PDO::ERRMODE_EXCEPTION);
//     echo "Holaaa";
// } catch (Exception $e) {
//     $conect = 'Error de conexión';
//     echo "ERROR: ".$e->getMessage();
// }
