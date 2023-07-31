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

$name = $_POST['name']; 

$query = "DELETE FROM customer_feedback WHERE name = '$name'";

if ($conn->query($query) === TRUE) {
    echo "feedback deleted successfully";
} else {
    echo "Error deleting feedback: " . $conn->error;
}

$conn->close();
?>
