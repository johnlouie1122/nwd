<?php
header('Access-Control-Allow-Origin: *');
$targetDir = "uploads/";

if (
    isset($_FILES["file1"]) && $_FILES["file1"]["error"] === UPLOAD_ERR_OK &&
    isset($_FILES["file2"]) && $_FILES["file2"]["error"] === UPLOAD_ERR_OK &&
    isset($_FILES["file3"]) && $_FILES["file3"]["error"] === UPLOAD_ERR_OK &&
    isset($_FILES["file4"]) && $_FILES["file4"]["error"] === UPLOAD_ERR_OK &&
    isset($_FILES["file5"]) && $_FILES["file5"]["error"] === UPLOAD_ERR_OK &&
    isset($_POST['name'])
) {
    $servername = "localhost";
    $username = "smcc";
    $password = "smcc@202";
    $dbname = "ocsms-nwd";

    $conn = new PDO("mysql:host=$servername;dbname=$dbname", $username, $password);
    $conn->setAttribute(PDO::ATTR_ERRMODE, PDO::ERRMODE_EXCEPTION);

    $name = $_POST['name'];
    $randomNumber = $_POST['randomNumber'];

    $stmt = $conn->prepare("SELECT COUNT(*) FROM registration WHERE name = ?");
    $stmt->execute([$name]);
    $rowExists = $stmt->fetchColumn() > 0;

    if (!$rowExists) {
        
        $stmt = $conn->prepare("INSERT INTO registration (name) VALUES (?)");
        $stmt->execute([$name]);
    }

    $stmt = $conn->prepare("UPDATE registration SET water_permit = ?, waiver = ?, lot_title = ?, valid_id = ?, brgy_certificate = ?, status = 'PENDING (REQUIREMENTS)', type = 'MAIN APPLICANT', orientation_code = ?, orientation_status = 'PENDING' WHERE name = ?");
    $stmt->execute([
        $_FILES["file1"]["name"],
        $_FILES["file2"]["name"],
        $_FILES["file3"]["name"],
        $_FILES["file4"]["name"],
        $_FILES["file5"]["name"],
        $randomNumber,
        $name,
    ]);

    $lastInsertId = $conn->lastInsertId();

    $folderPath = $targetDir . '/' . $name;
    if (!file_exists($folderPath)) {
        mkdir($folderPath, 0777, true);
    }

    $tempFilePath1 = $_FILES["file1"]["tmp_name"];
    $waterpermitName = $_FILES["file1"]["name"];
    $targetFilePath1 = $folderPath . '/' . $waterpermitName;

    $tempFilePath2 = $_FILES["file2"]["tmp_name"];
    $waiverName = $_FILES["file2"]["name"];
    $targetFilePath2 = $folderPath . '/' . $waiverName;

    $tempFilePath3 = $_FILES["file3"]["tmp_name"];
    $lotTitleName = $_FILES["file3"]["name"];
    $targetFilePath3 = $folderPath . '/' . $lotTitleName;

    $tempFilePath4 = $_FILES["file4"]["tmp_name"];
    $validIDName = $_FILES["file4"]["name"];
    $targetFilePath4 = $folderPath . '/' . $validIDName;

    $tempFilePath5 = $_FILES["file5"]["tmp_name"];
    $brgyCertificateName = $_FILES["file5"]["name"];
    $targetFilePath5 = $folderPath . '/' . $brgyCertificateName;

    if (
        move_uploaded_file($tempFilePath1, $targetFilePath1) &&
        move_uploaded_file($tempFilePath2, $targetFilePath2) &&
        move_uploaded_file($tempFilePath3, $targetFilePath3) &&
        move_uploaded_file($tempFilePath4, $targetFilePath4) &&
        move_uploaded_file($tempFilePath5, $targetFilePath5)
    ) {
        echo "File uploaded successfully!";
    } else {
        echo "Error occurred while uploading the files.";
    }

    $conn = null;
} else {
    echo "No files uploaded or error occurred during upload.";
}
?>
