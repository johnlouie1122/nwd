<?php
header('Access-Control-Allow-Origin: *');

$title = $_POST['title'];
$content = $_POST['content'];
$date = date('Y-m-d');


$servername = "localhost";
$username = "root";
$password = "";
$dbname = "nwd";

$conn = new mysqli($servername, $username, $password, $dbname);
if ($conn->connect_error) {
    die("Connection failed: " . $conn->connect_error);
}


$sql = "INSERT INTO promos (title, content, date)
        VALUES ('$title', '$content', '$date')";

if ($conn->query($sql) === TRUE) {
    echo "Data inserted successfully";
} else {
    echo "Error inserting data: " . $conn->error;
}

$conn->close();
?>
