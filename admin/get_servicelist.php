<?php
header('Access-Control-Allow-Origin: *');

$servername = 'localhost';
$username = 'root';
$password = '';
$dbname = 'nwd';

$conn = new mysqli($servername, $username, $password, $dbname);
if ($conn->connect_error) {
    die('Connection failed: ' . $conn->connect_error);
}

if (isset($_GET['table'])) {
    $table = $_GET['table'];

 
    $query = "SELECT * FROM $table";
    
    $result = $conn->query($query);

    $services = array();

    if ($result->num_rows > 0) {
        while ($row = $result->fetch_assoc()) {
            $services[] = $row;
        }
    }

    $conn->close();

    header('Content-Type: application/json');
    echo json_encode($services);
} else {

    echo json_encode(array('error' => 'Table name not provided'));
}
?>
