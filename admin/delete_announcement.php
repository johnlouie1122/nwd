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

$title = $_POST['title'];

$query = "DELETE FROM announcements WHERE title = '$title'";

if ($conn->query($query) === TRUE) {
    echo "Announcement deleted successfully";
} else {
    echo "Error deleting announcement: " . $conn->error;
}

$conn->close();
?>
