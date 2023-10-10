<?php

header('Access-Control-Allow-Origin: *');

require_once '../../admin/db_connection.php'; 

$conn = new mysqli($servername, $username, $password, $dbname);


if ($conn->connect_error) {
    die("Connection failed: " . $conn->connect_error);
}


$oldAccountName = $_POST['oldAccountName'];
$accountNumber = $_POST['accountNumber'];
$newAccountName = $_POST['newAccountName'];
$contactNumber = $_POST['contactNumber'];
$date = date('Y-m-d');


$folderName = "../uploads/" . $oldAccountName;
if (!file_exists($folderName)) {
    mkdir($folderName, 0777, true); 
}


if ($_FILES['file2']['error'] === UPLOAD_ERR_OK) {
    $waiverName = $_FILES['file2']['name'];
    $waiverPath = $folderName . "/" . $waiverName;
    move_uploaded_file($_FILES['file2']['tmp_name'], $waiverPath);
}

$sql = "INSERT INTO transfer_ownership (date, old_name, account_number, new_name, contact_number, waiver, status, type, reason)
        VALUES ('$date', '$oldAccountName', '$accountNumber', '$newAccountName', '$contactNumber','$waiverName', 'PENDING', 'MAIN APPLICANT', 'NORMAL TRANSFER')";

if ($conn->query($sql) === TRUE) {
    echo "Data inserted successfully";
} else {
    echo "Error: " . $sql . "<br>" . $conn->error;
}

$conn->close();
?>
