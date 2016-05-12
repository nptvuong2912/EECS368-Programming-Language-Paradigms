<!-- Authors: Main Front End: Logan Ayer
              Main Back End : Vuong Nguyen 
	 Date Last Edited: 5/9/2016 
	 ViewUserPosts.php is currently not integrated with the front end
	 Function does work though: Test is by visiting: 
	 ../Admin/ViewUserPosts.php 
	 Works with ViewUserPosts2.php to accomplish viewing posts from a single user-->

<!DOCTYPE html>
<html> 
<head>
		<meta charset="utf-8" />
		<meta http-equiv="Content-type" content="text/html; charset=utf-8" />
		<meta name="viewport" content="width=device-width, initial-scale=1" />
		<title> Posts by users </title>
       
		<style type="text/css">
		
		</style>
</head>

<body>
	<div class="container">
		<div class="header">
			<h3> View saved posts </h3>
			<br>
			<label>Select an user: </label>
			
			<?php
				// Connection to the database and start the session 
				require("../common.php");
				
				//retrieve data from database
				$result = $conn->query("SELECT user_id FROM Users");
				
				//check query
				if(!$result) {
					die ("failed to run query.");
				} 
	
				echo "<form method='post' action='ViewUserPosts2.php'>";
				echo "<select name='userid' onchange='this.form.submit()'>";
					while($row = $result->fetch_assoc()) {
						echo '<option value="' . $row['user_id'] . '">' . $row['user_id'] . '</option>';
	
					}
					$result->free();
				echo "</select>";
				echo "</form>";
				?>
			 <br> <br> <br> <a href='privateAdmin.php'>Back to Admin Home</a>    
			<br> <a href="logoutAdmin.php">Logout</a>

		</div>
	
	</div>     
</body>
</html> 