<?php

include("include.php");

if ($_SERVER["REQUEST_METHOD"] == "POST") {
    $username = $_POST['username'];
    $password = $_POST['password'];

    $checkUsernameQuery = "SELECT * FROM players WHERE player_name = '$username'";
    $checkUsernameResult = $conn->query($checkUsernameQuery);

    if ($checkUsernameResult === false) {
        http_response_code(500);
        echo json_encode(['status' => 'error', 'message' => $conn->error]);
    } else {
        if ($checkUsernameResult->num_rows > 0) {
            http_response_code(200);
            echo json_encode(['status' => 'error', 'message' => 'Username already taken']);
        } else {
            $insertUserQuery = "INSERT INTO players (player_name, Password) VALUES ('$username', '$password')";

            if ($conn->query($insertUserQuery) === true) {
                http_response_code(200);
                echo json_encode(['status' => 'success', 'message' => 'Player registered successfully']);
            } else {
                http_response_code(500);
                echo json_encode(['status' => 'error', 'message' => $conn->error]);
            }
        }
    }
}

$conn->close();
?>
