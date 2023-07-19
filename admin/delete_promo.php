<?php
header('Access-Control-Allow-Origin: *');

$host = "localhost";
$username = "root";
$password = "";
$database = "nwd";

$conn = new mysqli($host, $username, $password, $database);

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
