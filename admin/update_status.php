<?php
header('Access-Control-Allow-Origin: *');

require_once 'db_connection.php'; 

$conn = new mysqli($servername, $username, $password, $dbname);
if ($conn->connect_error) {
    die("Connection failed: " . $conn->connect_error);
}

$id = $_POST['id'];
$status = $_POST['status'];
$table = $_POST['table'];
// $contact = $_POST['contact'];

$sql = "UPDATE $table SET status = '$status' WHERE id = '$id'";

if ($conn->query($sql) === TRUE) {
    echo "Status updated successfully";
} else {
    echo "Error updating status: " . $conn->error;
}

echo $res->getBody(); 

$conn->close();
?>
