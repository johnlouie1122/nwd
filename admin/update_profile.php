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

$firstName = $_POST['firstName'];
$lastName = $_POST['lastName'];
$username = $_POST['username'];
$imageName = $_POST['imageName'];

$userUploadsDir = "uploads/$username";
if (!is_dir($userUploadsDir)) {
    mkdir($userUploadsDir, 0777, true);
}

if ($_FILES["file1"]["error"] === UPLOAD_ERR_OK) {
    $targetDir = "$userUploadsDir/";
    $targetFile = $targetDir . basename($imageName);

    if (move_uploaded_file($_FILES["file1"]["tmp_name"], $targetFile)) {
       
    } else {
        echo "Error uploading the image.";
        exit;
    }
}

$sql = "UPDATE user SET firstName='$firstName', lastName='$lastName'";
if ($_FILES["file1"]["error"] === UPLOAD_ERR_OK) {
    $sql .= ", image='$imageName'";
}
$sql .= " WHERE username='$username'";

if ($conn->query($sql) === TRUE) {
    echo "Data updated successfully";
} else {
    echo "Error: " . $sql . "<br>" . $conn->error;
}

$conn->close();
?>
