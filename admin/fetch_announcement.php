<?php
header('Access-Control-Allow-Origin: *');

$host = "localhost";
$username = "smcc";
$password = "smcc@2020";
$database = "ocsms-nwd";

$conn = new mysqli($host, $username, $password, $database);

if ($conn->connect_error) {
    die("Connection failed: " . $conn->connect_error);
}

$query = "SELECT title, content FROM announcements";
$result = $conn->query($query);

if ($result->num_rows > 0) {
    $announcements = array();
    while ($row = $result->fetch_assoc()) {
        $announcements[] = $row;
    }
    echo json_encode($announcements);
} else {
    echo json_encode([]);   
}

$conn->close();
?>
