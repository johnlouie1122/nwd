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


$query = "SELECT * FROM service_list";
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
?>
