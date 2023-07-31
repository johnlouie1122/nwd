<?php
header('Access-Control-Allow-Origin: *');

$applicantName = $_POST['applicantName'];
$status = $_POST['status'];
$randomNumber = $_POST['randomNumber'];

$servername = "localhost";
$username = "smcc";
$password = "smcc@2020";
$dbname = "ocsms-nwd";

$conn = new mysqli($servername, $username, $password, $dbname);
if ($conn->connect_error) {
    die("Connection failed: " . $conn->connect_error);
}

$sql = "UPDATE registration SET status = '$status'";

if ($_POST['type'] === 'MAIN APPLICANT') {
    $sql .= ", main_applicant_code = '$randomNumber'";
} elseif ($_POST['type'] === 'REPRESENTATIVE') {
    $sql .= ", representative_code = '$randomNumber'";
}

$sql .= " WHERE name = '$applicantName'";

if ($conn->query($sql) === TRUE) {
    echo "Status updated successfully";
} else {
    echo "Error updating status: " . $conn->error;
}

$conn->close();
?>
