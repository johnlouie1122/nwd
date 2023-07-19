<?php
header('Access-Control-Allow-Origin: *');

$hostname = 'localhost';
$username = 'root';
$password = '';
$database = 'nwd';

$conn = new mysqli($hostname, $username, $password, $database);

if ($conn->connect_error) {
    die("Connection failed: " . $conn->connect_error);
}

$accountName = $_POST['accountName'];
$accountNumber = $_POST['accountNumber'];
$landmark = $_POST['landmark'];
$contact = $_POST['contact'];

$date = date('Y-m-d');

$stmt = $conn->prepare("INSERT INTO service_list (account_name, account_number, landmark, contact_number, date, status, type) VALUES (?, ?, ?, ?, ?, 'PENDING', 'RECONNECTION')");
$stmt->bind_param("sssss", $accountName, $accountNumber, $landmark, $contact, $date);

if ($stmt->execute()) {
    echo "success";
} else {
    echo "failure";
}

$stmt->close();
$conn->close();
?>
