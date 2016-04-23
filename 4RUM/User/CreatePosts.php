<html>
<head>
	<title> Submitted </title>
</head>
<body>
	<?php

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
	Successfully added new post. <br> <br>
	<a href="CreatePosts.html">Write another post</a><br />
	<a href="private.php">Back to 4RUM</a><br />
	<a href="logout.php">Logout</a>
</body>
</html>