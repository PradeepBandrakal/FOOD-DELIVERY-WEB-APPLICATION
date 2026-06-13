
<%@ page language="java"
contentType="text/html; charset=UTF-8"
pageEncoding="UTF-8"%>

<!DOCTYPE html>

<html>

<head>

<meta charset="UTF-8">

<title>User Registration</title>

<!-- GOOGLE FONT -->

<link rel="preconnect"
href="https://fonts.googleapis.com">

<link rel="preconnect"
href="https://fonts.gstatic.com"
crossorigin>

<link href="https://fonts.googleapis.com/css2?family=Poppins:wght@300;400;500;600;700&display=swap"
rel="stylesheet">

<!-- CSS -->

<link rel="stylesheet"
href="css/global.css">

<link rel="stylesheet"
href="css/register.css">

</head>

<body>

<div class="register-page">

    <div class="register-card">

        <!-- TITLE -->

        <h1 class="register-title">

            Create Account 🚀

        </h1>

        <p class="register-subtitle">

            Register to start ordering delicious food

        </p>

        <!-- FORM -->

        <form action="register"
              method="post">

            <!-- NAME -->

            <div class="input-group">

                <input type="text"
                       name="name"
                       placeholder="Enter Name"
                       required
                       class="register-input">

            </div>

            <!-- EMAIL -->

            <div class="input-group">

                <input type="email"
                       name="email"
                       placeholder="Enter Email"
                       required
                       class="register-input">

            </div>

            <!-- PHONE -->

            <div class="input-group">

                <input type="text"
                       name="phone"
                       placeholder="Enter Phone"
                       required
                       class="register-input">

            </div>

            <!-- ADDRESS -->

            <div class="input-group">

                <textarea name="address"
                          placeholder="Enter Address"
                          required
                          class="register-input register-textarea"></textarea>

            </div>

            <!-- PASSWORD -->

            <div class="input-group">

                <input type="password"
                       name="password"
                       placeholder="Enter Password"
                       required
                       class="register-input">

            </div>

            <!-- BUTTON -->

            <button type="submit"
                    class="register-btn">

                Register

            </button>

        </form>

        <!-- LOGIN -->

        <div class="login-text">

            Already have an account?

            <a href="login.jsp">

                Login

            </a>

        </div>

    </div>

</div>

</body>

</html>
