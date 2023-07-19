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

$code = $_POST['code'];
$status = $_POST['status'];

$code = mysqli_real_escape_string($conn, $code);
$status = mysqli_real_escape_string($conn, $status);

$sql = "UPDATE registration SET orientation_status = '$status' WHERE orientation_code = '$code'";

if ($conn->query($sql) === TRUE) {
    echo "Orientation status updated successfully.";
} else {
    echo "Error updating orientation status: " . $conn->error;
}

$conn->close();
?>
