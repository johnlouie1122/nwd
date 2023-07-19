<?php
header('Access-Control-Allow-Origin: *');

$servername = "localhost";
$username = "root";
$password = "";
$dbname = "nwd";

$conn = new mysqli($servername, $username, $password, $dbname);

if ($conn->connect_error) {
  die("Connection failed: " . $conn->connect_error);
}

$sql = "SELECT status, name, address, contact_number, type, landmark, nearest_existing_customer, orientation_status, certificate_code FROM registration";
$result = $conn->query($sql);

$status = array();

if ($result->num_rows > 0) {
  while ($row = $result->fetch_assoc()) {
    $status[] = $row;
  }
}

header('Content-Type: application/json');
echo json_encode($status);

$conn->close();
?>
