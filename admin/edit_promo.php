<?php
header('Access-Control-Allow-Origin: *');

$connection = mysqli_connect("localhost", "root", "", "nwd");

if (!$connection) {
    die("Connection failed: " . mysqli_connect_error());
}
    
$currentTitle = $_POST['currentTitle']; 
$currentContent = $_POST['currentContent']; 
$title = $_POST['title'];
$content = $_POST['content'];

$sql = "UPDATE promos SET title = '$title', content = '$content' WHERE title = '$currentTitle' AND content = '$currentContent'";
if (mysqli_query($connection, $sql)) {
    echo "Promo updated successfully";
} else {
    echo "Error updating Promo: " . mysqli_error($connection);
}

mysqli_close($connection);
?>
