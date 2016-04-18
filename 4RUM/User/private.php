<?php
    // connection to the database and start the session
    require("../common.php");

 //At the top of the page we check to see whether the user is logged in or not
    if(empty($_SESSION['user']))
    {
       //If they are not, we redirect them to the login page.
        header("Location: login.php");

        //Remember that this die statement is absolutely critical.  Without it,
        // people can view your members-only content without logging in.
        die("Redirecting to login.php");
    }


?>
User ID: <?php echo htmlentities($_SESSION['user']['user_id']); ?> <br> <br>
<a href="CreatePosts.html">Write a post</a><br />
<a href="logout.php">Logout</a>
