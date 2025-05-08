<?php
    include 'db.php';

    $id = $_POST['id'];
    $name = $_POST['name'];


    $sql = "UPDATE usuariosapp SET name='$name' WHERE id=$id";

    if ($conn->query($sql)) {
        echo json_encode(["success" => true]);
    } else {
        echo json_encode(["success" => false]);
    }
?>