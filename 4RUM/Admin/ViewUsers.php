<html>
<head>
	<title> 4RUM-Users </title>
</head>
<body>
	<h1>List of users</h1>
	
	<?php
		// Connection to the database and start the session
		require("../common.php"); 

		// check to see whether the admin is logged in or not
		if(empty($_SESSION['user']))
		{
			// If they are not, redirect them to the login Admin page.
			header("Location: loginAdmin.php");

			die("Redirecting to loginAdmin.php");
		}


		// retrieve a list of members
		$query = "SELECT user_id FROM Users";

		$result = $conn->query($query);

		if(!$result) {
			die ("failed to run query.");
		} else {
				//Output data
				while($row = $result->fetch_assoc()) {
					echo "<br> User ID: ". $row["user_id"]. "<br>";
				}
				$result->free();
			}
	?>
	<br>
	<a href="privateAdmin.php">Back to menu</a> <br>
	<a href="logoutAdmin.php">Logout</a>
</body>