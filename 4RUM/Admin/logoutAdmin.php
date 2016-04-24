<?php
	// connection to the database and start the session
	require("../common.php"); 

	// We remove the user's data from the session
	unset($_SESSION['user']);

	// We redirect them to the login page
	header("Location: loginAdmin.php");
	die("Redirecting to: loginAdmin.php");
?>
