<?php
	//Authors: Main Front End: Logan Ayer
    //         Main Back End:  Vuong Nguyen 
	//Date Last Edited: 5/9/2016 
	//logoutAdmin.php ends session for the user

	// connection to the database and start the session
	require("../common.php"); 

	// We remove the user's data from the session
	unset($_SESSION['user']);

	// We redirect them to the login page
	header("Location: loginAdmin.php");
	die("Redirecting to: loginAdmin.php");
?>
