<?php

header('Access-Control-Allow-Origin: *');
$servername = "localhost";
$username = "root"; 
$password = "";
$dbname = "nwd";

$conn = new mysqli($servername, $username, $password, $dbname);

$applicant = $_GET['old_name'];
$query = "SELECT waiver, deed_sale, death, letter, rep_id FROM transfer_ownership WHERE name = '$applicant'";
$result = $conn->query($query);

if ($result->num_rows > 0) {
    $row = $result->fetch_assoc();
    $files = [];

    if (!empty($row['waiver'])) {
        $files[] = $row['waiver'];
    }
    if (!empty($row['deed_sale'])) {
        $files[] = $row['deed_sale'];
    }
    if (!empty($row['death'])) {
        $files[] = $row['death'];
    }
    if (!empty($row['letter'])) {
        $files[] = $row['letter'];
    }
    if (!empty($row['rep_id'])) {
        $files[] = $row['rep_id'];
    }
    

    echo json_encode($files);
} else {
    echo json_encode("No files found for the applicant.");
}

$conn->close();

?>
