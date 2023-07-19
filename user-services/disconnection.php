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

$accountName = $_POST['account_name'];
$accountNumber = $_POST['account_number'];
$previousReading = $_POST['previous_reading'];
$currentReading = $_POST['current_reading'];
$consumption = $_POST['consumption'];
$date = date('Y-m-d');

$stmt = $conn->prepare("INSERT INTO service_list (account_name, account_number, previous_reading, current_reading, consumption, date, status, type) VALUES (?, ?, ?, ?, ?, '$date', 'PENDING', 'DISCONNECTION')");
$stmt->bind_param("sssss", $accountName, $accountNumber, $previousReading, $currentReading, $consumption);

if ($stmt->execute()) {
    echo "success";
} else {
    echo "failure";
}

$stmt->close();
$conn->close();
?>
