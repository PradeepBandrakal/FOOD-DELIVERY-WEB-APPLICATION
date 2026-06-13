
<%@ page language="java"
contentType="text/html; charset=UTF-8"
pageEncoding="UTF-8"%>

<!DOCTYPE html>

<html>

<head>

<meta charset="UTF-8">

<title>User Login</title>

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
href="css/login.css">

</head>

<body>

<div class="login-page">

    <!-- LEFT -->

    <div class="login-left">

        <div class="brand-content">

            <h1>
                Foodie
            </h1>

            <p>
                Delicious food delivered
                at your doorstep anytime.
            </p>

        </div>

    </div>

    <!-- RIGHT -->

    <div class="login-right">

        <div class="login-card">

            <!-- TITLE -->

            <h1 class="login-title">

                Welcome Back 👋

            </h1>

            <p class="login-subtitle">

                Login to continue ordering delicious food

            </p>

            <!-- ERROR -->

            <%

            String error =
            request.getParameter("error");

            if(error != null){

            %>

            <div class="error-box">

                Invalid Email or Password!

            </div>

            <%

            }

            %>

            <!-- FORM -->

            <form action="login"
                  method="post">

                <!-- EMAIL -->

                <div class="input-group">

                    <input type="email"
                           name="email"
                           placeholder="Enter Email"
                           required
                           class="login-input">

                </div>

                <!-- PASSWORD -->

                <div class="input-group">

                    <input type="password"
                           name="password"
                           placeholder="Enter Password"
                           required
                           class="login-input">

                </div>

                <!-- BUTTON -->

                <button type="submit"
                        class="login-btn">

                    Login

                </button>

            </form>

            <!-- REGISTER -->

            <div class="register-text">

                Don't have an account?

                <a href="register.jsp">

                    Register

                </a>

            </div>

        </div>

    </div>

</div>

</body>

</html>
