<?php
include 'include.php';

$getHitsQuery = "SELECT player_id, totalhits, attempts FROM hits ORDER BY attempts ASC"; 

$getHitsResult = $conn->query($getHitsQuery);

if ($getHitsResult) {
    if ($getHitsResult->num_rows > 0) {
        $hits = array(); 

        while ($row = $getHitsResult->fetch_assoc()) {
            $hit = array(
                'playerId' => $row['player_id'], 
                'totalHits' => $row['totalhits'],
                'attempts' => $row['attempts']
            );

            array_push($hits, $hit);
        }

        echo json_encode($hits);
    } else {
        echo ('No data found in the Hits table');
    }
} else {
    echo ('Error executing the query: ' . $conn->error);
}

$conn->close();
?>
