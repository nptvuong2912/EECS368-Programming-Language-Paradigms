<!-- Authors: Main Front End: Logan Ayer
              Main Back End : Vuong Nguyen 
	 Date Last Edited: 5/9/2016 
	 login.php is the form that controls 
	 loginning in to 4Rum -->
<html>
<head>
	<title> Login to 4Rum </title>
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
			
			/* The background div that sits behind the login form */
			#loginback {
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
			
			/* Actual form styling */
			#loginform {
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

			// Connection to the database and start the session
			require("../common.php"); 

			$userid = $_POST['userid'];
			$password = $_POST['password'];

			if(!empty($_POST)) {
				//Retrieves the user's user_id from database
				$query = " SELECT  user_id,  password FROM Users WHERE user_id = '$userid' ";
				$result= $conn->query($query);

				if (!$result)
				{
					die("Failed to run query.");
				}

				$loginCheck = false;

				$row = $result->fetch_assoc();

				//verify password
				if($row) {
					if(password_verify($password, $row['password'])) {
						$loginCheck = true;
					}
				}

				if ($loginCheck) {
					//stores user's data into the session at index 'user'
					//Later will check this index on the private.php to see if the user's logged in.
					$_SESSION['user'] = $row;

					//redirect the user to private page
					header("Location: private.php");
					die("Redirecting to: private.php");
				} else {
					die ("Login failed.");
				}
			}
		?>

	<!-- All elements of the header -->
	<div id="header">
		<div id="headerlogo">
			<a href="private.php"></a>
		</div>
		<ul>
			<li>
				<a href="register.html" title="Register">Register</a> 
			</li>
			<li>
				<a href="../Admin/AdminHome.html" title="Admin">Admin</a> 
			</li>
		</ul>
	</div>
	
	<!-- Background for the login form -->
	<div id="loginback">
	</div>
	
	<!-- Div controlling the login form -->
	<div id="loginform">
		<h1>Login</h1>
		<form action="login.php" method="post">
			User ID:<br />
			<input type="text" name="userid" required/>
			<br /><br />
			Password:<br />
			<input type="password" name="password" value="" required/>
			<br /><br />
			<input type="submit" value="Login" />
		</form>
	</div>
</body>
</html>