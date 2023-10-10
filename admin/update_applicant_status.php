<?php
header('Access-Control-Allow-Origin: *');

$name = $_POST['name'];
$status = $_POST['status'];
$randomNumber = $_POST['randomNumber'];


require_once 'db_connection.php'; 

$conn = new mysqli($servername, $username, $password, $dbname);
if ($conn->connect_error) {
    die("Connection failed: " . $conn->connect_error);
}

$sql = "UPDATE registration SET status = '$status'";

if ($_POST['type'] === 'MAIN APPLICANT') {
    $sql .= ", main_applicant_code = '$randomNumber'";
} else if ($_POST['type'] === 'REPRESENTATIVE') {
    $sql .= ", representative_code = '$randomNumber'";
} 

if ($_POST['status'] === 'ORIENTATION') {
    $sql .= ", orientation_code = '$randomNumber'";
}

$sql .= " WHERE name = '$name'";

if ($conn->query($sql) === TRUE) {
    echo "Status updated successfully";
} else {
    echo "Error updating status: " . $conn->error;
}

$conn->close();
?>
