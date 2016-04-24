<html>
<head>
	<title> Edit your profile </title>
</head>
<body>
	<?php 

		//connection to the database and start the session 
		require("../common.php"); 
		 
		//check to see whether the user is logged in or not 
		if(empty($_SESSION['user'])) { 
			// If they are not, redirect them to the login page. 
			header("Location: login.php"); 
			 
			die("Redirecting to login.php"); 
		} 
		 
		$password = $_POST['password'];
		$userid = $_SESSION['user']['user_id']; //current user
		
		if(!empty($_POST)) {     
			// if submit a new password, store the new hashed password to database
			if(!empty($_POST['password'])) { 
				$hash = password_hash($password, PASSWORD_DEFAULT);
			} 
			else { 
				// If the user did not enter a new password, keep the old password
				$hash = null; 
			} 
			 
			// If the user is changing their password, then we need parameter values 
			// for the new password hash and salt too. 
			if($hash !== null) { 
				$query = "UPDATE Users SET password = '$hash' WHERE user_id = '$userid'";
				$result = $conn->query($query);
				
				if(!$result) {
					die("Failed to run query: ");
				}
			}  
			 
			//Redirects back to the private page after the user update their profiles
			header("Location: private.php"); 

			die("Redirecting to login.php"); 
		} 
		 
	?> 
	<h1>Edit your profile</h1> 
	<form action="edit.php" method="post"> 
		Username: <b><?php echo htmlentities($_SESSION['user']['user_id']); ?></b> 
		<br /><br />  
		Password:<br /> 
		<input type="password" name="password" value="" /><br /> 
		<i>(leave blank if you do not want to change your password)</i> 
		<br /><br /> 
		<input type="submit" value="Update" /> 
	</form>
	<a href="private.php">Back to 4RUM</a><br />
	<a href="logout.php">Logout</a>
</body>
</html>	