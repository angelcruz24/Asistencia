<?php
    include 'conexion.php';

    $nombre = $_POST['nombre'];
    $clave = $_POST['clave'];

    $sql = "INSERT INTO usuariosapp (nombre, clave, estatus) VALUES ('$nombre', '$clave', 1)";

    if ($conn->query($sql)) {
        echo json_encode(["success" => true]);
    } else {
        echo json_encode(["success" => false]);
    }
?>
