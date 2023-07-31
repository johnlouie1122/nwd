<?php
header('Access-Control-Allow-Origin: *');

$servername = "localhost";
$username = "smcc";
$password = "smcc@2020";
$database = "ocsms-nwd";

$conn = new mysqli($servername, $username, $password, $database);

if ($conn->connect_error) {
    die("Connection failed: " . $conn->connect_error);
}

$sql = "SELECT name, feedback FROM customer_feedback";
$result = $conn->query($sql);

$feedbackList = array();

if ($result->num_rows > 0) {
    while ($row = $result->fetch_assoc()) {
        $feedbackList[] = $row;
    }
}

$conn->close();

header('Content-Type: application/json');
echo json_encode($feedbackList);
?>
