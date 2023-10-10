<?php
header('Access-Control-Allow-Origin: *');

if ($_SERVER['REQUEST_METHOD'] === 'POST') {
  $user_name = $_POST['username'];
  $user_password = $_POST['password'];

  require_once 'db_connection.php'; 

  $stmt = $conn->prepare("SELECT * FROM user WHERE username = ? AND password = ?");
  $stmt->bind_param("ss", $user_name, $user_password);
  $stmt->execute();
  $result = $stmt->get_result();

  if ($result->num_rows > 0) {
    $user_details = $result->fetch_assoc();
    $response = array('status' => 'success', 'message' => 'Login successful', 'user' => $user_details);
} else {
    $response = array('status' => 'error', 'message' => 'Invalid username or password');
}

  $stmt->close();
  $conn->close();

  echo json_encode($response);
} else {
  $response = array('status' => 'error', 'message' => 'Invalid request method');
  echo json_encode($response);
}
?>
