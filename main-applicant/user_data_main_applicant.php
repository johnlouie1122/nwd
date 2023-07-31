<?php
header('Access-Control-Allow-Origin: *');

$servername = "localhost";
$username = "smcc";
$password = "smcc@2020";
$dbname = "ocsms-nwd";

$conn = new mysqli($servername, $username, $password, $dbname);

if ($conn->connect_error) {
    die("Connection failed: " . $conn->connect_error);
}

$code = $_POST['code'];

$stmt = $conn->prepare("SELECT * FROM registration WHERE main_applicant_code = ?");
$stmt->bind_param("s", $code);
$stmt->execute();
$result = $stmt->get_result();

if ($result->num_rows > 0) {
    $row = $result->fetch_assoc();

    $userData = array(
        'name' => $row['name'],
        'address' => $row['address'],
        'contactNumber' => $row['contact_number']
    );

    echo json_encode($userData);
} else {
    echo "failure";
}

$stmt->close();
$conn->close();
?>
