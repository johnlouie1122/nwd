<?php

header('Access-Control-Allow-Origin: *');

require_once'db_connection.php';

$conn = new mysqli($servername, $username, $password, $dbname);

if ($conn->connect_error) {
    die("Connection failed: " . $conn->connect_error);
}


$firstName = $_POST['firstName'];
$lastName = $_POST['lastName'];
$username = $_POST['username'];
$password = $_POST['password'];
$role = $_POST['role'];


$sql = "INSERT INTO user (firstName, lastName, username, password, role, status)
        VALUES ('$firstName', '$lastName', '$username', '$password', '$role', 'active')";

if ($conn->query($sql) === TRUE) {
    echo "User added successfully";
} else {
    echo "Error: " . $sql . "<br>" . $conn->error;
}

$conn->close();
?>
