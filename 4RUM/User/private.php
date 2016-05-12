<!-- Authors: Main Front End: Logan Ayer
              Main Back End : Vuong Nguyen 
	 Date Last Edited: 5/9/2016 
	 private.php is the actual 4Rum that 
	 displays messages from users -->
<html>
<head>
	<title> 4Rum </title>
	<style>
			/* background image with goal of maintaining size and position independent of browswer size */
			html { 
			 background: url(../4Rum.png) no-repeat center center fixed; 
			 -webkit-background-size: cover;
			 -moz-background-size: cover;
			 -o-background-size: cover;
			 background-size: cover;
			}
	
			/* controls the header element at top of page
            stays at top regardless of everything else */
			#header {
			 position:fixed;
			 display:block;
			 top: 0px;
			 left: 0px;
			 width:100%;
			 height:40px;
			 z-index: 10000;
			 background:#EEEEEE;
			 box-shadow: 0px 5px 5px #888888
			}
			
			/* Thumbnail icon on right of header */
			#headerlogo a {
				background: url("../4RumHeader.png");
				display: block;
				height: 40px;
				margin-right: 5px;
				width: 100px;
				text-indent: -9999px;
				float:left;
			}
			
			/* controls clickable elements of header on right side */
			#header ul {
			  margin:0;
			  padding: 0;
			  background: transparent;
			  height:100%;
			  margin-right:25px;
			  padding-right:0px;
			  padding-top:10px;
			  float: right;
			}
			
			/*controls the post form*/
			#header form {
			  margin:0;
			  padding: 0;
			  background: transparent;
			  height:100%;
			  padding-top:10px;
			}
			
			/* keeps header elements 'inline' */
			#header ul li {  
			  display:inline-block;
			  margin-left: 25px;
			}
			
			/* formats text color and removes underline */
			#header ul li a { 
				padding-right:0px;
				color:#000000;
				text-decoration:none;
			}
			
			/* hover animation - changes color and underlines the text */
			#header ul li a:hover {
				color:#999999; 
				text-decoration: underline;
			}
			
			/* Div that holds the table */
			#data {
				position: absolute;
				top: 50px;
				width:70%; 
				margin-left:15%; 
				margin-right:15%;
			  background: #111111;
			  border-radius: 8px;
			  text-align: center;
			}
			
			/* the actual table of data from users */
			#datatable {
				color: #FFFFFF;
				text-align:center; 
				margin-left:auto; 
				margin-right:auto; 
				width:50%;
			}
			
			/* table styling */
			#datatable tr,td {
				text-align:left;
				border-bottom: 1px solid #DDDDDD;
			}
			
			/* hover animation for table */
			#datatable tr:hover {
				background-color: #333333;
			}
	</style>
</head>
<body>
<script src="https://ajax.googleapis.com/ajax/libs/jquery/1.11.3/jquery.min.js"></script>
	<!-- Div that holds the table of user posts -->
	<div id='data'>
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
	</div>
	
	<!-- All elements of the header -->
	<div id="header">
		<div id="headerlogo">
			<a href="private.php"></a>
		</div>
		<form method="post" action="write-post.php" style="display:inline-block;">
		<!-- Ajax elements to update form on submit -->
			<script>
				function CommunicateWithServer(){
					var ajaxFilename = "write-post.php"; // This is the name of the file that is going to get the variables we send
					var data = { post: $('#post').val() }; // Get the value of the search term box and put it in our data object. Call it 'inp'
		
					var jqxhr = $.post(ajaxFilename, data, function(datafromserver) {	// Send the data to the file specified (A)
						// At this point the server has finished working with the data we sent and has sent us a response (B)
						// the 'datafromserver' variable contains the data sent from the server.
				
						// Lets dump everything the server sent us into the 'matches' div
						$('#data').html(datafromserver);
				
					});
				}
			
				$( document ).ready(function() {
					// Function called when the value of the "searchterm" box is changed
					$('#submit').click(function(e){
						e.preventDefault();
						CommunicateWithServer();
					});
				});
			</script>
			
			<label>Write a post: </label><input type="text" name="post" placeholder="What are you thinking?.." id="post">  
			<input type="submit" value="Submit" id="submit">
		</form>
		<ul>
			<li>
				<a href="edit.php" title="View Profile"><?php echo htmlentities($_SESSION['user']['user_id']); ?></a> 
			</li>
			<li>
				<a href="logout.php" title="Logout">Logout</a> 
			</li>
			<li>
				<a href="../Admin/AdminHome.html" title="Admin">Admin</a> 
			</li>
		</ul>
	</div>
</body>
</html>