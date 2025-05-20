<?php
header("Content-Type: application/json"); // Se indica que se responderá con formato JSON
header("Access-Control-Allow-Origin: *");  // Permite solicitudes desde cualquier origen
header("Access-Control-Allow-Methods: GET, POST, PUT, DELETE, OPTIONS"); // Métodos permitidos
header("Access-Control-Allow-Headers: Content-Type, Authorization"); // Encabezados permitidos

// Si la solicitud es OPTIONS, solo responde con 200 (preflight)
if ($_SERVER['REQUEST_METHOD'] === 'OPTIONS') {
    http_response_code(200);
    exit();
}

require_once "conexion.php";  // Archivo con la conexión a la base de datos

$accion = $_GET['accion'] ?? $_POST['accion'] ?? '';  // Acción enviada por GET o POST para que nuestros cases puedan ser manejados

switch ($accion) {
    case 'ping':    // Caso ping para Verificar si la API está activa
        echo json_encode(['success' => true, 'message' => 'API en línea']);
        break;

    case 'login':
        $data = json_decode(file_get_contents("php://input"), true);    // Recibe y decodifica los datos JSON

        // Verifica si el usuario y la clave están definidos y que si se reciben
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
                // Agregan o devuelven el id y nombre
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
        header('Content-Type: application/json');
        // Obtener la fecha y hora acutal del servidor y regresarla como json para usarla en la app
        date_default_timezone_set('America/Mexico_City');   // Zona horaria de México
        // Obtener fecha y hora actual del servidor
        $fecha = date("Y-m-d");
        $hora = date("H:i:s");
        // Obtener fecha y hora actual del servidor y regresa en formato JSON
        echo json_encode([
            'success' => true,
            'fecha' => $fecha,
            'hora' => $hora
        ]);
        break;

    case 'consultarentrada':
        // Buscamos en la db si y a hay una entrada registrada, si la hay se regresa el id
        $data = json_decode(file_get_contents("php://input"), true);    // Recibe y decodifica los datos JSON
        // Verificar que se recibió el ID del usuario y la fecha
        if (isset($data['idusuario']) && isset($data['fechaentrada'])) {
            $idusuario = $conn->real_escape_string($data['idusuario']);
            $fechaentrada = $conn->real_escape_string($data['fechaentrada']);
            // Buscar entrada resgistrada en la tabla
            $sql = "SELECT id FROM asistencialistado WHERE idusuario='$idusuario' AND fechaentrada='$fechaentrada'";
            $result = $conn->query($sql);   // Ejecuta la consulta
            // Si hay una entrada registrada
            if ($result && $result->num_rows > 0) {
                $row = $result->fetch_assoc();  // Obtiene el ID de la entrada
                echo json_encode(['success' => true, 'id' => $row['id']]);  // Devuelve el ID de la entrada
            } else {
                echo json_encode(['success' => false, 'message' => 'No hay entrada registrada']);   // No hay entrada
            }
        } else {
            echo json_encode(['success' => false, 'message' => 'Datos incompletos']);   // Faltan campos
        }
        break;

    case 'guardarentrada':
        //guardar en la db la entrada
        $data = json_decode(file_get_contents("php://input"), true);    // Recibe y decodifica los datos JSON
        // Verifica que se recibieron todos los campos requeridos
        if (
           isset($data['usuario'], $data['fechaentrada'], $data['horaentrada'], 
              $data['ipentrada'], $data['bssidentrada'], $data['uuidentrada'])
        ) {
            // Se limpian los valores para prevenir inyecciones SQL
            $usuario = $conn->real_escape_string($data['usuario']);
            $ipentrada = $conn->real_escape_string($data['ipentrada']);
            $bssidentrada = $conn->real_escape_string($data['bssidentrada']);
            $uuidentrada = $conn->real_escape_string($data['uuidentrada']);

            // Fecha y hora actual del servidor
            $fechaentrada = date("Y-m-d");
            $horaentrada = date("H:i:s");
            // Consulta para insertar la entrada en la base de datos
            $sql = "INSERT INTO asistencia (usuario, fechaentrada, horaentrada, ipentrada, bssidentrada, uuidentrada)
                    VALUES ('$usuario', '$fechaentrada', '$horaentrada', '$ipentrada', '$bssidentrada', '$uuidentrada')";
            // Si la inserción fue exitosa
            if ($conn->query($sql)) {
                $idasistencia = $conn->insert_id;   // Se hace el registro correctamente y obtiene el ID de la nueva entrada
                echo json_encode(['success' => true, 'message' => 'Entrada registrada correctamente', 'id' => $idasistencia]);
            } else {
                http_response_code(500);    // Error del servidor
                echo json_encode(['success' => false, 'message' => 'Error al registrar entrada', 'error' => $conn->error]);
            }
        } else {
            echo json_encode(['success' => false, 'message' => 'Faltan datos requeridos']);
        }
        break;

    case 'guardarsalida':
        // Acción para registrar la salida (actualiza datos existentes)
         $data = json_decode(file_get_contents("php://input"), true);   // Recibe y decodifica los datos JSON
         // Verifica que todos los campos necesarios estén presentes
        if (
            isset($data['id']) && isset($data['fechasalida']) && isset($data['horasalida']) &&
            isset($data['ipsalida']) && isset($data['bssidsalida']) &&
            isset($data['uuidsalida']) && isset($data['actividades'])
        ) {
            // Se limpian los valores para prevenir inyecciones SQL
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
            // Si la actualización fue exitosa
            if ($conn->query($sql)) {
                echo json_encode(['success' => true, 'message' => 'Salida registrada correctamente']);
            } else {
                echo json_encode(['success' => false, 'message' => 'Error al registrar salida', 'error' => $conn->error]);  // Faltan campos
            }
        } else {
            echo json_encode(['success' => false, 'message' => 'Datos incompletos para registrar salida']);
        }
        break;

    // Acción para obtener todos los usuarios
    case 'GET':
        $result = $conn->query("SELECT * FROM usuariosapp");  // Consulta todos los registros
        $usuarios = [];  // Inicializa arreglo de usuarios
        while ($row = $result->fetch_assoc()) {
            $usuarios[] = $row;  // Agrega cada usuario al arreglo
        }
        echo json_encode($usuarios);  // Devuelve los usuarios en formato JSON
        break;

    // Acción para actualizar un usuario
    case 'PUT':
        $data = json_decode(file_get_contents("php://input"), true);  // Lee datos JSON
        $id = intval($data['id']);  // Convierte el ID a entero
        $nombre = $conn->real_escape_string($data['nombre']);  // Escapa el nombre
        $clave = $conn->real_escape_string($data['clave']);  // Escapa la clave

        // Consulta para actualizar
        $sql = "UPDATE usuariosapp SET nombre='$nombre', clave='$clave' WHERE id=$id";

        // Ejecuta y verifica si tuvo éxito
        if ($conn->query($sql)) {
            echo json_encode(['message' => 'Usuario actualizado']);
        } else {
            http_response_code(500);  // Error del servidor
            echo json_encode(['error' => $conn->error]);
        }
        break;

    // Acción para eliminar un usuario
    case 'DELETE':
        parse_str(file_get_contents("php://input"), $data);  // Parsea datos enviados por DELETE
        $id = intval($data['id']);  // Convierte el ID a entero

        // Consulta para eliminar
        $sql = "DELETE FROM usuariosapp WHERE id=$id";

        // Ejecuta y verifica si tuvo éxito
        if ($conn->query($sql)) {
            echo json_encode(['message' => 'Usuario eliminado']);
        } else {
            http_response_code(500);  // Error del servidor
            echo json_encode(['error' => $conn->error]);
        }
        break;

    // Acción no reconocida
    default:
        http_response_code(405);  // Método no permitido
        echo json_encode(['error' => 'Método no permitido']);  // Devuelve mensaje de error
        break;
}

// Cierra la conexión con la base de datos
$conn->close();