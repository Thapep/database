<?php
$servername = "localhost";
$username = "root";
$password = "SelectedAgainst";
$dbname = "mydb";

echo 'Hello World!' . '<br />';

$db = new mysqli($servername, $username, $password, $dbname);

if($db->connect_errno > 0){
    die('Unable to connect to database [' . $db->connect_error . ']');
}
echo 'Succesfull Connection' . '<br />';

$sql_search = '';
$sql_replace = '';

$ISBN = $_POST['ISBN'];

// If instead of the empty string ('') I use NULL the comparison returns TRUE (damn php and your types)
if ($ISBN !== ''){
    $sql_search = $sql_search . 'ISBN = ' . $ISBN . ' and ';
}


$title = $_POST['title'];
if ($title !== ''){
    $sql_search = $sql_search . 'title = \'' . $title . '\' and ';
}
$pubYear = $_POST['pubYear'];
if ($pubYear !== ''){
    $sql_search = $sql_search . 'pubYear = ' . $pubYear . ' and ';
}
$numpages = $_POST['numpages'];
if ($numpages !== ''){
    $sql_search = $sql_search . 'numpages = ' . $numpages . ' and ';
}
$pubName = $_POST['pubName'];
if ($pubName !== ''){
    $sql_search = $sql_search . 'pubName = ' . $pubName . ' and ';
}
if ($sql_search == ''){
    echo 'You have to fill at least one field to search for!';
    die();
}
$sql_search = substr($sql_search, 0, -5);

$ISBN_new = $_POST['ISBN_new'];
if ($ISBN_new !== ''){
    $sql_replace = $sql_replace . 'ISBN = ' . $ISBN_new . ' and ';
}
$title_new = $_POST['title_new'];
if ($title_new !== ''){
    $sql_replace = $sql_replace . 'title = ' . $title_new . ' and ';
}
$pubYear_new = $_POST['pubYear_new'];
if ($pubYear_new !== ''){
    $sql_replace = $sql_replace . 'pubYear = ' . $pubYear_new . ' and ';
}
$numpages_new = $_POST['numpages_new'];
if ($numpages_new !== ''){
    $sql_replace = $sql_replace . 'numpages = ' . $numpages_new . ' and ';
}
$pubName_new = $_POST['pubName_new'];
if ($pubName_new !== ''){
    $sql_replace = $sql_replace . 'pubName = \'' . $pubName_new . '\' and ';
}

if ($sql_replace == ''){
    echo 'You have to fill at least one field to change!';
    die();
}
$sql_replace = substr($sql_replace, 0, -5);


echo $sql_search . '<br />' . $sql_replace . '<br />';

$sql = '
UPDATE Book
SET ' . $sql_replace . '
WHERE ' . $sql_search . ';
';

if(!$result = $db->query($sql)){
    die('There was an error running the query [' . $db->error . ']');
}

while($row = $result->fetch_assoc()){
    echo $row['title'] . '<br />';
}

echo 'Affected Rows: ' . $result->affected_rows;


?>