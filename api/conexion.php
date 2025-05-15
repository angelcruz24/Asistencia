<?php

$host = "localhost";
/*$user = "asistencia";
$password = "asistencia2025";
$db = "asistencia";*/
//para el servidor
$user = "seismex1_asistencia";
$password = "i5YOUQC7S%lVñ";
$db = "seismex1_asistencia";

$conn = new mysqli($host, $user, $password, $db);

if ($conn->connect_error) {
    var_dump("Conexion fallida: " . $conn->connect_error);
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
