Guillaume POTIER

<!DOCTYPE html>
<html lang="en">
  <head>
    <meta charset="UTF-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Document</title>
  </head>
  <body>
    
    <form action="index.php" method="post">
      <p>Name: <input type="text" name="name"></p>
      <p>Age: <input type="number" name="age"></p>
      <input type="submit">
    </form>

    <?php
      class User {
        public $name;
        public $age;

        function __construct($name, $age) {
          $this->name = $name;
          $this->age = $age;
        }
      }

      $user_new = new User($_POST["name"], $_POST["age"]);
      echo $user_new->name . " - " . $user_new->age;

      // $users = array($user_new);
      // $u = foreach($users as $v) {

      // } ;
    ?>

  </body>
</html>