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
$reason = $_POST['reason'];

$folderName = "../uploads/" . $oldAccountName;
if (!file_exists($folderName)) {
    mkdir($folderName, 0777, true); 
}


if ($_FILES['file1']['error'] === UPLOAD_ERR_OK) {
    $repIdName = $_FILES['file1']['name'];
    $repIdPath = $folderName . "/" . $repIdName;
    move_uploaded_file($_FILES['file1']['tmp_name'], $repIdPath);
}


if ($_FILES['file2']['error'] === UPLOAD_ERR_OK) {
    $deedSaleName = $_FILES['file2']['name'];
    $deedSalePath = $folderName . "/" . $deedSaleName;
    move_uploaded_file($_FILES['file2']['tmp_name'], $deedSalePath);
}

$sql = "INSERT INTO transfer_ownership (date, old_name, account_number, new_name, contact_number, rep_id, deed_sale, status, type, reason)
        VALUES ('$date', '$oldAccountName', '$accountNumber', '$newAccountName', '$contactNumber', '$repIdName', '$deedSaleName', 'PENDING', 'REPRESENTATIVE', '$reason')";

if ($conn->query($sql) === TRUE) {
    echo "Data inserted successfully";
} else {
    echo "Error: " . $sql . "<br>" . $conn->error;
}

$conn->close();
?>
