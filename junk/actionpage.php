<?php

if(isset($_POST['submit'])){
$mailto = "samudraneel05@gmail.com";

// Get the form data
$name = $_POST['name'];
$fromEmail = $_POST['email'];
$phone = $_POST['phone'];
$subject = $_POST['subject'];
$subject2 = "Confirmation: Message was submitted successfully. -Sam";
$message = $_POST['message'];

// Mail to site owner
$message = "Sender Name: " . $name . "\n"
. "Phone number: " . $phone .  "\n\n"
. "Subject: " . "\n". $_POST['subject'] . "\n\n"
. "Message: " . "\n" . $_POST['message'];

//Mail to the person who contacted
$message2 = "Dear" . $name . "\n"
. "Thank you for contacting me. I shall get back to you very soon. Sit tight." . "\n\n"
. "You submitted the following message: " . "\n" . $_POST['message'] . "\n\n"
. "Regards," . "\n" . "-Samn";

// Headers
$headers = "From: "  . $fromEmail;
$headers2 = "FRom; " . $mailto;

// PHP mailer function
$result1 = mail($mailto, $subject, $message, $headers);
$result2 = mail($fromEmail, $subject2 ,$message2, $headers2);

// Check if mail sent successfully or not
if ($result1 && $result2) {
    $success = "Your message was sent successfully!. You rock!";
} else {
    $failed = " Sorry, your message was not sent :( . Try again!";
}
}

?>