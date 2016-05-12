<!-- Authors: Main Front End: Logan Ayer
              Main Back End : Vuong Nguyen 
	 Date Last Edited: 5/9/2016 
	 edit.php is the edit profile page for users
	 current functionalities: edit password -->
<html>
<head>
	<title> Your 4Rum Profile </title>
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
			
			/* The background div for the edit form */
			#editback {
			  position: absolute;
			  width: 300px;
			  height: 300px;
			  top: 50px;
			  left: 50%;
			  margin: 0 0 0 -150px;
			  background: #111111;
			  border-radius: 8px;
			  text-align: center;
			  z-index: 1000;
			}
			
			/*changes the actual edit form */
			#edit {
			  position: absolute;
			  width: 300px;
			  height: 300px;
			  color: #FFFFFF;
			  top: 50px;
			  left: 50%;
			  margin: 0 0 0 -150px;
			  background: transparent;
			  text-align: center;
			  z-index: 5000;
			}		
	</style>
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
	
	<!-- All elements of the header -->
	<div id="header">
		<div id="headerlogo">
			<a href="private.php"></a>
		</div>
		<ul>
			<li>
				<a href="logout.php" title="Logout">Logout</a> 
			</li>
			<li>
				<a href="../Admin/AdminHome.html" title="Admin">Admin</a> 
			</li>
		</ul>
	</div>
	
	<!-- Background for the edit form -->
	<div id="editback">
	</div>
	
	<!-- Div controlling the edit form -->
	<div id="edit">
		<h1>Your Profile</h1> 
		<form action="edit.php" method="post"> 
			Username: <b><?php echo htmlentities($_SESSION['user']['user_id']); ?></b> 
			<br /><br />  
			Change Password:<br /> 
			<input type="password" name="password" value="" required/><br /> 
			<i>(leave blank if you do not want to change your password)</i> 
			<br /><br /> 
			<input type="submit" value="Update" /> 
		</form>
	</div>
</body>
</html>