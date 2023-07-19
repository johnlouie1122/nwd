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

$accountName = $_POST['accountName'];
$status = $_POST['status'];

$sql = "UPDATE service_list SET status = '$status' WHERE account_name = '$accountName'";

if ($conn->query($sql) === TRUE) {
    echo "Status updated successfully";
} else {
    echo "Error updating status: " . $conn->error;
}

$conn->close();
?>
