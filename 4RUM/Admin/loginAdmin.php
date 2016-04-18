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
            header("Location: privateAdmin.php");
            die("Redirecting to: privateAdmin.php");
        } else {
            die ("Login failed.");
        }
    }
?>

<h1>Admin Login</h1>
<form action="loginAdmin.php" method="post">
    User ID:<br />
    <input type="text" name="userid" />
    <br /><br />
    Password:<br />
    <input type="password" name="password" value="" />
    <br /><br />
    <input type="submit" value="Login" />
</form>
<a href="../main.html">Back to main menu</a>
