	<?php
			//Authors: Main Front End: Logan Ayer
			//         Main Back End:  Vuong Nguyen 
			//Date Last Edited: 5/9/2016 
			//logout.php logs the user out and redirects to login.php
	
		// connection to the database and start the session
		require("../common.php"); 

		// We remove the user's data from the session
		unset($_SESSION['user']);

		// We redirect them to the login page
		header("Location: login.php");
		die("Redirecting to: login.php");
	?>
