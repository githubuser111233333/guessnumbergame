<?php
include("include.php");

if ($_SERVER['REQUEST_METHOD'] == 'POST') {
    $username = $_POST['username'];
    $password = $_POST['password'];

    $selectQuery = "SELECT * FROM players WHERE player_name = ? AND password = ?";
    $stmt = $conn->prepare($selectQuery);
    $stmt->bind_param("ss", $username, $password);
    $stmt->execute();
    $result = $stmt->get_result();

    if ($result->num_rows > 0) {
        $response = ['status' => 'success', 'message' => 'Successfully'];
    } else {
        $response = ['status' => 'error', 'message' => 'Invalid username or password'];
    }

    echo json_encode($response);
    $stmt->close();
}
?>
