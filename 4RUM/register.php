<?php

//Execute the common code to connect to database
require("common.php");

$userid = $_POST['userid'];
$password = $_POST['password'];

//Ensure non-empty input
if(!empty($_POST)) {

    if(empty($_POST['userid'])) {
        die ("Enter User ID");

    }
    if(empty($_POST['password'])) {
    die ("Enter password");

    }
}

 //Check if username has taken
    $query = " SELECT * FROM Users WHERE user_id = '$userid' ";
    $result= $conn->query($query);

        if (!$result)
        {
            die("Failed to run query.");
        }

        $row = $result->fetch_assoc();
        if($row)
        {
            die("This user id has been used.");
        }


    $hash = password_hash($password, PASSWORD_DEFAULT);

  // An INSERT query is used to add new rows to a database table.
       $query = "INSERT INTO Users (user_id, password) VALUES ('$userid', '$hash')";
        $result = $conn->query($query);

        if(!$result) {
            die("Failed to run query: ");
        }

        // This redirects the user back to the login page after they register
        header("Location: login.php");

        die("Redirecting to CreateUser.html");


?>
