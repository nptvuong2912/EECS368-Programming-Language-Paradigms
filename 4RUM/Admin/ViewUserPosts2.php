<!-- Authors: Main Front End: Logan Ayer
              Main Back End : Vuong Nguyen 
	 Date Last Edited: 5/9/2016 
	 Works with ViewUserPosts.php to accomplish viewing posts from a single user-->
<?php
    // onnection to the database and start the session
    require("../common.php"); 

    // check to see whether the admin is logged in or not
    if(empty($_SESSION['user']))
    {
        // If they are not, redirect them to the login Admin page.
        header("Location: loginAdmin.php");

        die("Redirecting to loginAdmin.php");
    }


    //user selected -> author of the posts
    $author = $_POST['userid'];

    $result = $conn->query("SELECT * FROM Posts WHERE author_id ='" . $author . "'");

    //check query
    if(!$result) {
        die ("failed to run query.");
    } else {

            if($result->num_rows === 0) {
                echo "The user with ID: ". $author . " has not submitted any post.";
            } else {

                //build the table of Post ID and Content from $author
                echo "<h2>Posts by " . $author . "</h2>";
                echo "<table>";
                echo "<tr>";
                        echo "<th>Post ID</th>";
                        echo "<th>Content</th>";
                echo "<tr>";
                while($row = $result->fetch_assoc()) {
                    echo "<tr>";
                    echo "<td>" . $row['post_id'] . "</td>"."<td>" . $row['content'] . "</td>";
                    echo "</tr>";
                }
                $result->free();

                echo "</table>";

            }
    }

    echo "<br> <br> <a href='ViewUserPosts.html'>Select another user</a><br>";
    echo "<a href='privateAdmin.php'>Back to Admin Menu</a>";

?>
