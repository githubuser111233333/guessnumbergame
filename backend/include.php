<?php

define("DATABASE_SERVER","localhost");
define("DATABASE_USER","id21745540_guessnumber");
define("DATABASE_PASS","76466575Aa$");
define("DATABASE_NAME","id21745540_guessnumber12");

$conn = mysqli_connect(DATABASE_SERVER, DATABASE_USER, DATABASE_PASS, DATABASE_NAME);

    if ($conn->connect_error) {
        die("Connection failed: " . $conn->connect_error);
    }

?>