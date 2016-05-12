<!-- Authors: Main Front End: Logan Ayer
              Main Back End : Vuong Nguyen 
	 Date Last Edited: 5/9/2016 
	 DeletePost.php displays all posts with an
	 option to delete them all.
	 Works with DeletePost2.php-->
<html> 
	<head>
		<title> Delete Posts </title>
		<style type="text/css">
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
			
			/*background for the content table */
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
			
			/*actual table styling */
			#datatable {
				color: #FFFFFF;
				text-align:center; 
				margin-left:auto; 
				margin-right:auto; 
				width:50%;
			}
			
			/* table element styling */
			#datatable tr,td {
				color: #FFFFFF;
				text-align:left;
				border-bottom: 1px solid #DDDDDD;
			}
			
			/*hover animation of table */
			#datatable tr:hover {
				background-color: #333333;
			}
		</style>
	</head>

<body>
	<?php
		// connection to the database and start the session
		require("../common.php"); 

		//At the top of the page we check to see whether the user is logged in or not
		if(empty($_SESSION['user']))
		{
			// If they are not, we redirect them to the login page.
			header("Location: loginAdmin.php");

			//Remember that this die statement is absolutely critical.  Without it,
			// people can view your members-only content without logging in.
			die("Redirecting to login.php");
		}
		
		//Open 4RUM - Saved Posts
		$result = $conn->query("SELECT post_id, content, author_id FROM Posts ORDER BY post_id DESC");

		//check query
		if(!$result) {
			die ("failed to run query.");
		} else {
			echo "<div id='data'>";
			echo "<form action='DeletePost2.php' method='post' id='datatable'>";    
			//drawing a table of posts
			echo "<table>";
			echo "<tr><td></td><td><h3>Select posts to delete</h3></td></tr>";			
			while($row = $result->fetch_assoc()) {
				echo "<tr>";
				echo "<td>" . $row['author_id'] . "</td>";
				echo "<td>" . $row['content'] . "</td>";
				echo "<td>" . "<input type='checkbox' name='delete[]' value='" .$row['post_id']. "'>" . "</td>";
					echo "</tr>";
			}
				
			echo "</table>";
			echo "<br><input type='submit' value='Delete'>";
		echo "</form>";
		echo "</div>";
		}
		$conn->close();
	?>
	<!-- All elements of the header -->
	<div id="header">
		<div id="headerlogo">
			<a href="privateAdmin.php"></a>
		</div>
		<ul>
			<li>
				<a href="../User/edit.php" title="View Profile">Admin: <?php echo htmlentities($_SESSION['user']['user_id']); ?></a> 
			</li>
			<li>
				<a href="ViewUsers.php" title="View Users">User List</a> 
			</li>
			<li>
				<a href="logoutAdmin.php" title="Logout">Logout</a> 
			</li>
		</ul>
	</div>
</body>

</html> 