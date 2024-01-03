<?php
include 'include.php';

$username = $_POST['username'];
$attempts = (int)$_POST['attempts'];

$checkplayerQuery = "SELECT player_id, totalhits, attempts FROM hits WHERE player_id = (SELECT player_id FROM players WHERE player_name = '$username')";
$checkResult = $conn->query($checkplayerQuery);

if ($checkResult->num_rows > 0) {
    $row = $checkResult->fetch_assoc();
    $player_id = $row['player_id'];
    $totalhits = $row['totalhits'] + 1;
    $currentattempts = $row['attempts'];
    $maxAttempt = $currentattempts + $attempts;

    $updateplayerQuery = "UPDATE hits SET attempts = $maxAttempt, totalhits = $totalhits WHERE player_id = $player_id";

    if ($conn->query($updateplayerQuery) === TRUE) {
        echo json_encode(array('message' => 'hits updated successfully', 'newRecord' => false));
    } else {
        echo json_encode(array('message' => 'Error updating hits: ' . $conn->error, 'newRecord' => false));
    }
} else {
    $maxAttempt = $attempts;

    $insertplayereQuery = "INSERT INTO hits (player_id, totalhits, attempts) VALUES ((SELECT player_id FROM players WHERE player_name = '$username'), 1, $maxAttempt)";
    if ($conn->query($insertplayereQuery) === TRUE) {
        echo json_encode(array('message' => 'hits inserted successfully', 'newRecord' => true));
    } else {
        echo json_encode(array('message' => 'Error inserting hits: ' . $conn->error, 'newRecord' => false));
    }
}

$conn->close();
?>
