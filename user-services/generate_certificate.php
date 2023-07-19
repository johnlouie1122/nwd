<?php
header('Access-Control-Allow-Origin: *');

$servername = "localhost";
$username = "root";
$password = "";
$dbname = "nwd";

$certificateCode = $_POST['certificate_code']; 
$registrationCode = $_POST['code']; 


$conn = new mysqli($servername, $username, $password, $dbname);


if ($conn->connect_error) {
    die("Connection failed: " . $conn->connect_error);
}

$sql = "UPDATE registration SET certificate_code = '$certificateCode' WHERE orientation_code = '$registrationCode'";

if ($conn->query($sql) === TRUE) {
    echo "Certificate code updated successfully";
} else {
    echo "Error updating certificate code: " . $conn->error;
}

$conn->close();

?>
