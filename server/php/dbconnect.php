<?php
$servername = "localhost";
$username = "javathre_littlecakestoryadmin";
$password = "UUM217kachi";
$dbname = "javathre_littlecakestorydb";

$con = new mysqli($servername,$username,$password,$dbname);
if($conn->connect_error){
    die("Connection failed: " . $conn->connect_error);
}
?>