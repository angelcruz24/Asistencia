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

    case 'login':
        $data = json_decode(file_get_contents("php://input"), true);

        // Verifica si el usuario y la clave están definidos
        if (isset($data['nombre']) && isset($data['clave'])) {
            $nombre = $conn->real_escape_string($data['nombre']);
            $clave = $conn->real_escape_string($data['clave']);

            // Consulta para verificar si las credenciales coinciden aqui tambien obtener el id,nombre de usuario y regresarlo a la app
            $sql = "SELECT id,nombre FROM usuariosapp WHERE nombre='$nombre' AND clave='$clave' AND estatus='1'";
            $result = $conn->query($sql);

            // Verifica si se encontró un resultado
            if ($result && $result->num_rows > 0) {
                // Si hay coincidencia, devuelve un mensaje de éxito
                $usuario = $result->fetch_assoc();
                //agregar que devuelva el nombre tambien
                echo json_encode(['success' => true, 'message' => 'Credenciales correctas', 'id' => $usuario['id'], 'nombre' => $usuario['nombre']]);
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

    case 'fechahora':
        //obtener la fecha y hora acutal del servidor. y regresarla como json para usarla en la app
        //date_default_timezone_set('America/Mexico_City'); // Solo se coloca si necesitamos solo para un servidor 
        $fecha = date("Y-m-d");
        $hora = date("H:i:s");
        echo json_encode([
            'success' => true,
            'fecha' => $fecha,
            'hora' => $hora
        ]);
        break;

    case 'consultarentrada':
        //buscamos en la db si y a hay una entrada registrada, si la hay se regresa el id
        //$result = $conn->query("SELECT id FROM asistencialistado WHERE idusuario='$id' AND fechaentrada='$fecha'");
        $data = json_decode(file_get_contents("php://input"), true);

        if (isset($data['idusuario']) && isset($data['fechaentrada'])) {
            $idusuario = $conn->real_escape_string($data['idusuario']);
            $fechaentrada = $conn->real_escape_string($data['fechaentrada']);

            $sql = "SELECT id FROM asistencialistado WHERE idusuario='$idusuario' AND fechaentrada='$fechaentrada'";
            $result = $conn->query($sql);

            if ($result && $result->num_rows > 0) {
                $row = $result->fetch_assoc();
                echo json_encode(['success' => true, 'id' => $row['id']]);
            } else {
                echo json_encode(['success' => false, 'message' => 'No hay entrada registrada']);
            }
        } else {
            echo json_encode(['success' => false, 'message' => 'Datos incompletos']);
        }
        break;

    case 'guardarentrada':
        //guardar en la db la entrada
        //$result = $conn->query("INSERT INTO asistencia(usuario,fechaentrada,horaentrada y lo demas hasta uuidentrada) VALUES");
        $data = json_decode(file_get_contents("php://input"), true);
        if (
            isset($data['usuario']) &&
            isset($data['ipentrada']) &&
            isset($data['bssidentrada']) &&
            isset($data['uuidentrada'])
        ) {
            $usuario = $conn->real_escape_string($data['usuario']);
            $ipentrada = $conn->real_escape_string($data['ipentrada']);
            $bssidentrada = $conn->real_escape_string($data['bssidentrada']);
            $uuidentrada = $conn->real_escape_string($data['uuidentrada']);

            // Fecha y hora del servidor
            $fechaentrada = date("Y-m-d");
            $horaentrada = date("H:i:s");

            $sql = "INSERT INTO asistencia (usuario, fechaentrada, horaentrada, ipentrada, bssidentrada, uuidentrada)
                    VALUES ('$usuario', '$fechaentrada', '$horaentrada', '$ipentrada', '$bssidentrada', '$uuidentrada')";

            if ($conn->query($sql)) {
                echo json_encode(['success' => true, 'message' => 'Entrada registrada correctamente']);
            } else {
                http_response_code(500);
                echo json_encode(['success' => false, 'message' => 'Error al registrar entrada', 'error' => $conn->error]);
            }
        } else {
            echo json_encode(['success' => false, 'message' => 'Faltan datos requeridos']);
        }
        break;

    case 'guardarsalida':
        //idasistencia=obtener el id que regresaconsultarentrada,
        //result = $conn->query("UPDATE asistencia SET todos los valores de salida WHERE id='$idasistencia'");
         $data = json_decode(file_get_contents("php://input"), true);
        if (
            isset($data['id']) && isset($data['fechasalida']) && isset($data['horasalida']) &&
            isset($data['ipsalida']) && isset($data['bssidsalida']) &&
            isset($data['uuidsalida']) && isset($data['actividades'])
        ) {
            $id = $conn->real_escape_string($data['id']); // id de la fila en la tabla asistencia
            $fechasalida = $conn->real_escape_string($data['fechasalida']);
            $horasalida = $conn->real_escape_string($data['horasalida']);
            $ipsalida = $conn->real_escape_string($data['ipsalida']);
            $bssidsalida = $conn->real_escape_string($data['bssidsalida']);
            $uuidsalida = $conn->real_escape_string($data['uuidsalida']);
            $actividades = $conn->real_escape_string($data['actividades']);
            
            // Actualizar la fila existente
            $sql = "UPDATE asistencia SET 
                        fechasalida='$fechasalida',
                        horasalida='$horasalida',
                        ipsalida='$ipsalida',
                        bssidsalida='$bssidsalida',
                        uuidsalida='$uuidsalida',
                        actividades='$actividades'
                    WHERE id='$id'";

            if ($conn->query($sql)) {
                echo json_encode(['success' => true, 'message' => 'Salida registrada correctamente']);
            } else {
                echo json_encode(['success' => false, 'message' => 'Error al registrar salida', 'error' => $conn->error]);
            }
        } else {
            echo json_encode(['success' => false, 'message' => 'Datos incompletos para registrar salida']);
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
