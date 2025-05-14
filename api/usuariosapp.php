<?php
header("Content-Type: application/json");
header("Access-Control-Allow-Origin: *");  // Permite solicitudes desde cualquier origen
header("Access-Control-Allow-Methods: GET, POST, PUT, DELETE, OPTIONS");
header("Access-Control-Allow-Headers: Content-Type, Authorization");

// Si la solicitud es OPTIONS, solo responde con 200 (preflight)
if ($_SERVER['REQUEST_METHOD'] === 'OPTIONS') {
    http_response_code(200);
    exit();
}

require_once "conexion.php";

$accion = $_GET['accion'];

switch ($accion) {
    case 'ping':
        echo json_encode(['success' => true, 'message' => 'API en línea']);
        break;
    
    case 'login':  // Esta es la acción para login
        $data = json_decode(file_get_contents("php://input"), true);

        // Verifica si el usuario y la clave están definidos
        if (isset($data['nombre']) && isset($data['clave'])) {
            $nombre = $conn->real_escape_string($data['nombre']);
            $clave = $conn->real_escape_string($data['clave']);

            // Consulta para verificar si las credenciales coinciden
            $sql = "SELECT id FROM usuariosapp WHERE nombre='$nombre' AND clave='$clave' AND estatus='1'";
            $result = $conn->query($sql);

            // Verifica si se encontró un resultado
            if ($result && $result->num_rows > 0) {
                // Si hay coincidencia, devuelve un mensaje de éxito
                $usuario = $result->fetch_assoc();
                echo json_encode(['success' => true, 'message' => 'Credenciales correctas', 'id' => $usuario['id']]);
            } else {
                // Si no hay coincidencia, devuelve un mensaje de error
                echo json_encode(['success' => false, 'message' => 'Credenciales incorrectas']);
            }

            //$conn->close();
        } else {
            // Si no se enviaron datos, retorna un error
            echo json_encode(['success' => false, 'message' => 'No se introdujeron datos de acceso']);
        }
        break;

    case 'GET':
        $result = $conn->query("SELECT * FROM usuariosapp");
        $usuarios = [];
        while ($row = $result->fetch_assoc()) {
            $usuarios[] = $row;
        }
        echo json_encode($usuarios);
        break;

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
