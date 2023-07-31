<?php
header('Access-Control-Allow-Origin: *');

$feedback = $_POST['feedback'];
$name = $_POST['name'];

$servername = "localhost";
$username = "smcc";
$password = "smcc@2020";
$dbname = "ocsms-nwd";

$conn = new mysqli($servername, $username, $password, $dbname);
if ($conn->connect_error) {
    die("Connection failed: " . $conn->connect_error);
}

$sql = "INSERT INTO customer_feedback (feedback, name)
        VALUES ('$feedback', '$name')";

if ($conn->query($sql) === TRUE) {
    echo "Data inserted successfully";
} else {
    echo "Error inserting data: " . $conn->error;
}

$conn->close();
?>
