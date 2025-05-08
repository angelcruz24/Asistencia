<?php
    include 'db.php';

    $id = $_POST['id'];

    $sql = "DELETE FROM usuariosapp WHERE id=$id";

    if ($conn->query($sql)) {
        json_encode(["success" => true]);
    } else {
        json_encode(["success" => false]);
    }
?>