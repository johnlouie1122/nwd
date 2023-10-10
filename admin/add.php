<?php
header('Access-Control-Allow-Origin: *');

require_once 'db_connection.php';

$title = $_POST['title'];
$db = $_POST['db'];
$content = $_POST['content'];
$date = date('Y-m-d');

$photoNames = []; 
$folderCreated = false; 

for ($i = 1; $i <= 5; $i++) {
    $fieldName = "file$i";

    if ($_FILES[$fieldName]['error'] === UPLOAD_ERR_OK) {
        $photoName = $_FILES[$fieldName]['name'];
        $photoPath = "../uploads/$db/" . $title . "/" . $photoName;

        if (!$folderCreated) {
            mkdir(dirname($photoPath), 0777, true);
            $folderCreated = true;
        }

        move_uploaded_file($_FILES[$fieldName]['tmp_name'], $photoPath);
        $photoNames[] = $photoName; 
    }
}

$sql = "INSERT INTO $db (title, content, date";

for ($i = 1; $i <= 5; $i++) {
    if (isset($photoNames[$i - 1])) {
        $sql .= ", photo$i";
    }
}

$sql .= ") VALUES ('$title', '$content', '$date'";

for ($i = 0; $i < 5; $i++) {
    if (isset($photoNames[$i])) {
        $sql .= ", '" . $photoNames[$i] . "'";
    }
}

$sql .= ")";

if ($conn->query($sql) === TRUE) {
    echo "Data inserted successfully";
} else {
    echo "Error inserting data: " . $conn->error;
}

$conn->close();
?>
