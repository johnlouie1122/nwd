<?php
header('Access-Control-Allow-Origin: *');

$feedback = $_POST['feedback'];
$name = $_POST['name'];

$servername = "localhost";
$username = "root";
$password = "";
$dbname = "nwd";

$conn = new mysqli($servername, $username, $password, $dbname);
if ($conn->connect_error) {
    die("Connection failed: " . $conn->connect_error);
}

$sql = "INSERT INTO customer_feedback (feedback, name, status)
        VALUES ('$feedback', '$name', 'NEW')";

if ($conn->query($sql) === TRUE) {
    echo "Data inserted successfully";
} else {
    echo "Error inserting data: " . $conn->error;
}

$conn->close();
?>
