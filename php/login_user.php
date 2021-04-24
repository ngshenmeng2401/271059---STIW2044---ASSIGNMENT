<?php

    error_reporting(0);
    include_once("dbconnect.php");
    $email = $_POST['email'];
    $password = sha1($_POST['password']);

    $sqllogin = "SELECT * FROM tbl_user WHERE user_email = '$email' AND password = '$password' AND otp = '0'";
    $result = $con->query($sqllogin);
    if($result->num_rows>0){
        while($row = $result ->fetch_assoc()){
            echo $data = "success,".$row["first_name"].",".$row["last_name"].",".$row["date_reg"].",".$row["rating"].",".$row["credit"].",".$row["status"];
            // echo "success";
        }
    }else{
        echo "failed";
    }
?>