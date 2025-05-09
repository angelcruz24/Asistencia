<?php

$host = "localhost";
$user = "root";
$password = "toor";
$db = "asistencia";

$conn = new mysqli($host, $user, $password, $db);

if ($conn->connect_error) {
    die("Conexion fallida: " . $conn->connect_error);
}

// $connectionString = "mysql:hos=$host;dbname=$db;charset=utf8";
// try {
//     $conect = new PDO($connectionString, $user, $password);
//     $conect->setAttribute(PDO::ATTR_ERRMODE, PDO::ERRMODE_EXCEPTION);
//     echo "Holaaa";
// } catch (Exception $e) {
//     $conect = 'Error de conexión';
//     echo "ERROR: ".$e->getMessage();
// }
