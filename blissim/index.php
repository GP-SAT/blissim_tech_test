<!-- Guillaume Potier -->
<!DOCTYPE html>
<html lang="en">
  <head>
    <meta charset="UTF-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Blissim form</title>
    <link rel="stylesheet" href="custom.css" type="text/css">
  </head>
  <body>
    <?php
      session_start(); // Initializing the session
      // Creating the User object with name and age attributes
      class User {
        public $username;
        public $age;

        function __construct($username, $age) {
          $this->username = $username;
          $this->age = $age;
        }
      }
    ?>

    <!-- Making the form with username and age inputs and submit button -->
    <div class="form">
      <form action="" method="POST" id="user-form">
        <h2>Blissim user form</h2>
        <input type="text" name="username" placeholder="Enter your username" minlength="4" maxlength="25" class="form-control input" required><br><br>
        <input type="number" name="age" placeholder="Enter your age" min="0" class="form-control input" required><br><br>
        <input type="submit" value="Submit" class="form-control submit"><br><br>
        <h3>Logged in users:</h3>
        <?php
          $new_user = new User(htmlspecialchars($_POST['username'], ENT_QUOTES, 'UTF-8'), htmlspecialchars($_POST['age'], ENT_QUOTES, 'UTF-8')); // Creating a User instance with the data sent through the form and storing it in a variable and using htmlspecialchars to prevent XSS attacks
          $_SESSION['users'][] = $new_user; // Adding the User instance to the session
          // Looping over the session to list all the users
          $count = 0;
          foreach($_SESSION['users'] as $new_user){
            echo '<div class="users">';
            $count++;
            echo "#".$count." - ".$new_user->username.", ".$new_user->age." y.o<br>\n";
            echo '</div>';
          }
        ?>
      </form>
    </div>
  </body>
</html>