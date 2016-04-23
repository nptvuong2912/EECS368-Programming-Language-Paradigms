<html>
<head>
	<title> 4RUM </title>
</head>
<body>
	<?php
		// connection to the database and start the session
		require("../common.php");

	 //At the top of the page we check to see whether the user is logged in or not
		if(empty($_SESSION['user']))
		{
		   //If they are not, we redirect them to the login page.
			header("Location: login.php");

			die("Redirecting to login.php");
		}
		
		//Open 4RUM - Saved Posts
		$result = $conn->query("SELECT post_id, content, author_id FROM Posts");

		//check query
		if(!$result) {
			die ("failed to run query.");
		} else {
				if($result->num_rows === 0) {
					echo "No post submitted";
				} else {
					//build the table of Post ID and Content from $author
					echo "<table>";
					echo "<tr>";
							echo "<th>Author</th>";
							echo "<th>Content</th>";
					echo "<tr>";
					while($row = $result->fetch_assoc()) {
						echo "<tr>";
						echo "<td>" . $row['author_id'] . "</td>"."<td>" . $row['content'] . "</td>";
						echo "</tr>";
					}
					$result->free();

					echo "</table>";
					echo "<br><br>";
				}
		}

	?>
	Username: <?php echo htmlentities($_SESSION['user']['user_id']); ?> <br> <br>
	<a href="CreatePosts.html">Write a post</a><br />
	<a href="edit.php"> Edit your profile </a> <br>
	<a href="logout.php">Logout</a>
</body>
</html>