<?php
header('Access-Control-Allow-Origin: *');

require_once 'db_connection.php'; 

$conn = new mysqli($servername, $username, $password, $dbname);
if ($conn->connect_error) {
    die("Connection failed: " . $conn->connect_error);
}
    
$currentTitle = $_POST['currentTitle']; 
$currentContent = $_POST['currentContent']; 
$title = $_POST['title'];
$content = $_POST['content'];
$db = $_POST['db'];

$sql = "UPDATE $db SET title = '$title', content = '$content' WHERE title = '$currentTitle' AND content = '$currentContent'";
if (mysqli_query($conn, $sql)) {
    echo "Promo updated successfully";
} else {
    echo "Error updating Promo: " . mysqli_error($conn);
}

mysqli_close($conn);
?>
