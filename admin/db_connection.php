<?php
$servername = "localhost";
$username = "root";
$password = "";
$dbname = "nwd";

// Create a new database connection
$conn = new mysqli($servername, $username, $password, $dbname);

// Check the connection
if ($conn->connect_error) {
    die("Connection failed: " . $conn->connect_error);
}

// Set character set to UTF-8 (optional but recommended)
$conn->set_charset("utf8");

?>
