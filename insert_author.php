<html>
<body>
<?php
$servername = "localhost";
$username = "root";
$password = "hmysqlg@m31";
$dbname = "mydb";
$db = new mysqli($servername, $username, $password, $dbname);

if($db->connect_errno > 0){
    die('Unable to connect to database [' . $db->connect_error . ']');
}

$authID = $_POST['authID'];
$AFirst = $_POST['AFirst'];
$ALast = $_POST['ALast'];
$Abirthdate = $_POST['Abirthdate'];
//Checking to see if given parameters are NULL (Shouldn't the "NOT NULL" in the database be enough?)
if ($authID == NULL or $AFirst == NULL or $ALast == NULL or $Abirthdate == NULL){
    die('Please fill all the fields');
}
$sql = <<<SQL
    INSERT INTO author (authID, AFirst, ALast, Abirthdate)
    VALUES($authID, '$AFirst', '$ALast', '$Abirthdate');
SQL;

if(!$result = $db->query($sql)){
    die('There was an error running the query [' . $db->error . ']');
}
?>
<script>
    alert("Succesfull Insertion");
    window.location = 'insert_author.html';
</script>
</body>
</html>