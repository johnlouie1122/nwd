<?php

header('Access-Control-Allow-Origin: *');
$servername = "localhost";
$username = "root"; 
$password = "";
$dbname = "nwd";

$conn = new mysqli($servername, $username, $password, $dbname);

$applicant = $_GET['name'];
$query = "SELECT water_permit, waiver, lot_title, valid_id, brgy_certificate, authorization, valid_id_representative FROM registration WHERE name = '$applicant'";
$result = $conn->query($query);

if ($result->num_rows > 0) {
    $row = $result->fetch_assoc();
    $files = [];

    if (!empty($row['water_permit'])) {
        $files[] = $row['water_permit'];
    }
    if (!empty($row['waiver'])) {
        $files[] = $row['waiver'];
    }
    if (!empty($row['lot_title'])) {
        $files[] = $row['lot_title'];
    }
    if (!empty($row['valid_id'])) {
        $files[] = $row['valid_id'];
    }
    if (!empty($row['brgy_certificate'])) {
        $files[] = $row['brgy_certificate'];
    }
    if (!empty($row['authorization'])) {
        $files[] = $row['authorization'];
    }
    if (!empty($row['valid_id_representative'])) {
        $files[] = $row['valid_id_representative'];
    }

    echo json_encode($files);
} else {
    echo json_encode("No files found for the applicant.");
}

$conn->close();

?>
