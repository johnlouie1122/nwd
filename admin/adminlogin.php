<?php
header('Access-Control-Allow-Origin: *');

if ($_SERVER['REQUEST_METHOD'] === 'POST') {

  $username = $_POST['username'];
  $password = $_POST['password'];

  if ($username === 'admin' && $password === 'admin2021') {
    
    $response = array('status' => 'success', 'message' => 'Login successful');
    echo json_encode($response);
  } else {
    
    $response = array('status' => 'error', 'message' => 'Invalid username or password');
    echo json_encode($response);
  }
} else {
  
  $response = array('status' => 'error', 'message' => 'Invalid request method');
  echo json_encode($response);
}
