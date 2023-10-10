<?php
header('Access-Control-Allow-Origin: *');

require_once 'db_connection.php'; 

$conn = new mysqli($servername, $username, $password, $dbname);
if ($conn->connect_error) {
    die("Connection failed: " . $conn->connect_error);
}

$id = $_POST['id']; 

$query = "DELETE FROM customer_feedback WHERE id = '$id'";

if ($conn->query($query) === TRUE) {
    echo "feedback deleted successfully";
} else {
    echo "Error deleting feedback: " . $conn->error;
}

$conn->close();
?>
