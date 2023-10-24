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
$address = $_POST['address'];
$landmark = $_POST['landmark'];
$contact = $_POST['contact'];
$table = $_POST['table'];

$date = date('Y-m-d');

$contact = '+63' . substr($contact, 1);

$stmt = $conn->prepare("INSERT INTO $table (account_name, account_number, landmark, address, contact, date, status) VALUES (?, ?, ?, ?, ?, ?, 'PENDING')");
$stmt->bind_param("ssssss", $accountName, $accountNumber, $address, $landmark, $contact, $date);

if ($stmt->execute()) {
    echo "success";
} else {
    echo "failure";
}

$stmt->close();
$conn->close();
?>
