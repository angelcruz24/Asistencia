<?php
    include 'db.php';

    $name = $_POST['name'];

    $sql = "INSERT INTO usuariosapp (name) VALUES ('$name')";

    if ($conn->query($sql)) {
        echo json_encode(["success" => true]);
    } else {
        echo json_encode(["success" => false]);
    }
?>
