<?php
header("Content-Type: application/json");
include "conexion.php";

$method = $_SERVER['REQUEST_METHOD'];

switch ($method) {
    case 'GET':
        $result = $conn->query("SELECT * FROM usuariosapp");
        $usuarios = [];
        while ($row = $result->fetch_assoc()) {
            $usuarios[] = $row;
        }
        echo json_encode($usuarios);
        break;

    case 'POST':
        $data = json_decode(file_get_contents("php://input"), true);
        // Si es solo una prueba de login:
        if (isset($data['nombre']) && isset($data['clave']) && isset($data['prueba']) && $data['prueba'] == true) {
            $nombre = $conn->real_escape_string($data['nombre']);
            $clave = $conn->real_escape_string($data['clave']);

            $sql = "SELECT * FROM usuariosapp WHERE nombre='$nombre' AND clave='$clave'";
            $result = $conn->query($sql);

            if ($result->num_rows > 0) {
                echo json_encode(['success' => true, 'message' => 'Credenciales correctas']);
            } else {
                echo json_encode(['success' => false, 'message' => 'Credenciales incorrectas']);
            }
            $conn->close();
            // exit(); // Evita que siga al INSERT
        }
        // $nombre = $conn->real_escape_string($data['nombre']);
        // $clave = $conn->real_escape_string($data['clave']);
        // $estatus = isset($data['estatus']) ? intval($data['estatus']) : 1;

        // $sql = "INSERT INTO usuariosapp (nombre, clave, estatus) VALUES ('$nombre', '$clave', $estatus)";
        // if ($conn->query($sql)) {
        //     echo json_encode(['message' => 'Usuario creado']);
        // } else {
        //     http_response_code(500);
        //     echo json_encode(['error' => $conn->error]);
        // }
        // break;

    case 'PUT':
        $data = json_decode(file_get_contents("php://input"), true);
        $id = intval($data['id']);
        $nombre = $conn->real_escape_string($data['nombre']);
        $clave = $conn->real_escape_string($data['clave']);

        $sql = "UPDATE usuariosapp SET nombre='$nombre', clave='$clave' WHERE id=$id";
        if ($conn->query($sql)) {
            echo json_encode(['message' => 'Usuario actualizado']);
        } else {
            http_response_code(500);
            echo json_encode(['error' => $conn->error]);
        }
        break;

    case 'DELETE':
        parse_str(file_get_contents("php://input"), $data);
        $id = intval($data['id']);

        $sql = "DELETE FROM usuariosapp WHERE id=$id";
        if ($conn->query($sql)) {
            echo json_encode(['message' => 'Usuario eliminado']);
        } else {
            http_response_code(500);
            echo json_encode(['error' => $conn->error]);
        }
        break;

    default:
        http_response_code(405);
        echo json_encode(['error' => 'Método no permitido']);
        break;
}

$conn->close();
?>
