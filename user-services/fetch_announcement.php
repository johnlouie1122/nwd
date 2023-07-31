<?php
header('Access-Control-Allow-Origin: *');

$servername = "localhost";
$username = "smcc"; 
$password = "smcc@2020"; 
$dbname = "ocsms-nwd";

$conn = new mysqli($servername, $username, $password, $dbname);


if ($conn->connect_error) {
    die("Connection failed: " . $conn->connect_error);
}


$sql = "SELECT title, content, date FROM announcements";
$result = $conn->query($sql);

$response = array();

if ($result->num_rows > 0) {
    
    while ($row = $result->fetch_assoc()) {
       
        $response[] = $row;
    }
}

$conn->close();

header('Content-Type: application/json');
echo json_encode($response);
?>
