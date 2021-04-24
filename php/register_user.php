<?php

use PHPMailer\PHPMailer\PHPMailer;
use PHPMailer\PHPMailer\Exception;

require '/home8/javathre/public_html/s271059/littlecakestory/php/PHPMailer/Exception.php';
require '/home8/javathre/public_html/s271059/littlecakestory/php/PHPMailer/PHPMailer.php';
require '/home8/javathre/public_html/s271059/littlecakestory/php/PHPMailer/SMTP.php';
include_once("dbconnect.php");

$firstname = $_POST['firstname'];
$lastname = $_POST['lastname'];
$email = $_POST['email'];
$password = $_POST['password'];
$passha1 = sha1($password);
$otp = rand(100000,999999);
$rating = "0";
$credit = "0";
$status = "active";

$sqlregister="INSERT INTO tbl_user(first_name,last_name,user_email,password,otp,rating,credit,status) VALUES ('$firstname','$lastname','$email','$passha1','$otp','$rating','$credit','$status')";
if($con->query($sqlregister) === TRUE){
    
    echo "success";
    sendEmail($email,$otp);
}else{
    echo "failed";
}

function sendEmail($email,$otp){
    
    $mail = new PHPMailer(true);
    $mail->SMTPDebug = 0;                           //Disable verbose debug output
    $mail->isSMTP();                                //Send using SMTP
    $mail->Host       = 'mail.javathree99.com';                         //Set the SMTP server to send through
    $mail->SMTPAuth   = true;                       //Enable SMTP authentication
    $mail->Username   = 'littlecakestory@javathree99.com';                         //SMTP username
    $mail->Password   = 'KACHI217uum';                         //SMTP password
    $mail->SMTPSecure = 'tls';         
    $mail->Port       = 587;
    
    $from = "littlecakestory@javathree99.com";
    $to = $email;
    $subject = "From Little Cake Story. Please vertify your account";
    $message = "<p>Click the following link to verify your account<br><br><a href='https://javathree99.com/s271059/littlecakestory/php/vertify_account.php?email=".$email."&key=".$otp."'>Click Here</a>";

    $mail->setFrom($from,"Little Cake Story");
    $mail->addAddress($to);                                             //Add a recipient
    
    //Content
    $mail->isHTML(true);                                                //Set email format to HTML
    $mail->Subject = $subject;
    $mail->Body    = $message;
    $mail->send();
}
?>