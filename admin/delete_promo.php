<?php
header('Access-Control-Allow-Origin: *');

require_once 'db_connection.php'; 

$conn = new mysqli($servername, $username, $password, $dbname);
if ($conn->connect_error) {
    die("Connection failed: " . $conn->connect_error);
}

$title = $_POST['title'];

$query = "DELETE FROM promos WHERE title = '$title'";

if ($conn->query($query) === TRUE) {
    echo "Promo deleted successfully";
} else {
    echo "Error deleting promos: " . $conn->error;
}

$conn->close();
?>
