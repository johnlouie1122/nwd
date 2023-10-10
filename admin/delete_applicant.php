<?php
header('Access-Control-Allow-Origin: *');

require_once 'db_connection.php'; 

try {
    $conn = new PDO("mysql:host=$servername;dbname=$dbname", $username, $password);
    $conn->setAttribute(PDO::ATTR_ERRMODE, PDO::ERRMODE_EXCEPTION);

    $applicantName = $_POST['applicantName'];

    $stmt = $conn->prepare("DELETE FROM registration WHERE name = :applicantName");
    $stmt->bindParam(':applicantName', $applicantName);
    $stmt->execute();

    $folderPath = '../uploads/' . $applicantName;
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