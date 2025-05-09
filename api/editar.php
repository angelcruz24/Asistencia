<?php
    include 'conexion.php';

    $id = $_POST['id'];
    $nombre = $_POST['nombre'];
    $clave = $_POST['clave'];


    $sql = "UPDATE usuariosapp SET nombre='$nombre', clave='$clave' WHERE id=$id";

    if ($conn->query($sql)) {
        echo json_encode(["success" => true]);
    } else {
        echo json_encode(["success" => false]);
    }
?>