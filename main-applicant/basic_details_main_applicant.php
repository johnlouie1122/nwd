<?php
header('Access-Control-Allow-Origin: *');

$name = $_POST['name'];
$address = $_POST['address'];
$contactNumber = $_POST['contact_number'];
$landmark = $_POST['landmark'];
$nearestCustomer = $_POST['nearest_existing_customer'];
$date = date('Y-m-d');

$servername = "localhost";
$username = "root";
$password = "";
$dbname = "nwd";

$conn = new mysqli($servername, $username, $password, $dbname);
if ($conn->connect_error) {
    die("Connection failed: " . $conn->connect_error);
}

$contactNumber = '+63' . substr($contactNumber, 1);

$sql = "INSERT INTO registration (name, address, contact_number, landmark, nearest_existing_customer, type, status, date)
        VALUES ('$name', '$address', '$contactNumber', '$landmark', '$nearestCustomer', 'MAIN APPLICANT', 'PENDING (FOR EVALUATION)', '$date')";

if ($conn->query($sql) === TRUE) {
    echo "Data inserted successfully";
} else {
    echo "Error inserting data: " . $conn->error;
}

$conn->close();
?>
