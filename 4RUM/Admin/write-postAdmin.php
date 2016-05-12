<?php
			//Authors: Main Front End: Logan Ayer
			//         Main Back End:  Vuong Nguyen 
			//Date Last Edited: 5/9/2016 
			//write-postAdmin.php controls inputting posts into our database from privateAdmin

		// connection to the database and start the session
		require("../common.php"); 

		$post = $_POST['post'];
		$userid = $_SESSION['user']['user_id']; //current user

		//Ensure non-empty input
		if(!empty($_POST)) {

			if(empty($_POST['post'])) {
				die ("Enter a post");
			}
		}

		 //Insert post accorading to existing user id
			$query = "INSERT INTO Posts (content, author_id) VALUES ('$post', '$userid')";
			$result = $conn->query($query);

			if(!$result) {
				die("Failed to run query: ");
			}

	?>
	<?php
		// connection to the database and start the session
		require("../common.php");

	 //At the top of the page we check to see whether the user is logged in or not
		if(empty($_SESSION['user']))
		{
		   //If they are not, we redirect them to the login page.
			header("Location: loginAdmin.php");

			die("Redirecting to loginAdmin.php");
		}
		
		//Open 4RUM - Saved Posts
		$result = $conn->query("SELECT post_id, content, author_id FROM Posts ORDER BY post_id DESC");

		//check query
		if(!$result) {
			die ("failed to run query.");
		} else {
				if($result->num_rows === 0) {
					echo "No posts submitted";
				} else {
					//build the table of Content from the authors
					echo "<table id='datatable'>";
					while($row = $result->fetch_assoc()) {
						echo "<tr>";
						echo "<td>" . $row['author_id'] . "</td>"."<td>" . $row['content'] . "</td>";
						echo "</tr>";
					}
					$result->free();

					echo "</table>";
				}
		}
		$conn->close();
	?>