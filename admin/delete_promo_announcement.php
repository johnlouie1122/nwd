<?php
header('Access-Control-Allow-Origin: *');

require_once 'db_connection.php'; 

try {
    $conn = new PDO("mysql:host=$servername;dbname=$dbname", $username, $password);
    $conn->setAttribute(PDO::ATTR_ERRMODE, PDO::ERRMODE_EXCEPTION);

    $title = $_POST['title'];
    $table = $_POST['table'];
    $id = $_POST['id'];

    $stmt = $conn->prepare("DELETE FROM $table WHERE title = :title");
    $stmt->bindParam(':title', $title); 
    $stmt->execute();

    $folderPath = '../uploads/' . $table . '/' . $title;
    if (is_dir($folderPath)) {
        $success = deleteFolder($folderPath);
        if ($success) {
            echo "Row and folder deleted successfully";
        } else {
            echo "Failed to delete folder";
        }
    } else {
        echo "Folder does not exist";
    }
} catch (PDOException $e) {
    echo "Error: " . $e->getMessage();
}

function deleteFolder($folderPath) {
    $files = glob($folderPath . '/*');
    foreach ($files as $file) {
        if (is_file($file)) {
            unlink($file);
        } elseif (is_dir($file)) {
            deleteFolder($file);
        }
    }
    return rmdir($folderPath);
}
?>
