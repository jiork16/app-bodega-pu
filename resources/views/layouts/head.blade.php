<!DOCTYPE html>
<html lang="en">

<head>
    <script src="{{ asset('js/jquery-3.5.1.js') }}"></script>
    <link rel="stylesheet" href="{{ asset('css/bootstrap.css') }}">
    <script src="{{ asset('js/bootstrap.js') }}"></script>
</head>

<body>
    @yield('body')
</body>
<style>
    body {
        margin: 0;
        padding: 0;
        background-color: #1a202c;
        height: 100vh;
    }

    #login .container #login-row #login-column #login-box {
        margin-top: 120px;
        max-width: 600px;
        height: 320px;
        border: 1px solid #ffffff;
        background-color: #ffffff;
    }

    #login .container #login-row #login-column #login-box #login-form {
        padding: 20px;
    }

    #login .container #login-row #login-column #login-box #login-form #register-link {
        margin-top: -85px;
    }

</style>

</html>
