<!DOCTYPE html>
<html>
<head>
  <meta charset="utf-8">
  <meta name="viewport" content="width=device-width, initial-scale=1">
  <link rel="stylesheet" type="text/css" href="../assets/css/bootstrap.min.css">
  <title>AuthoRevw</title>
  <style>
    .navbar {
      background: linear-gradient(35deg,  rgba(255,255,255), rgba(99, 43, 43) 25%, rgba(0, 63, 94) 100%);
      position: sticky;
      top: 0;
      z-index: 1;
    }
  </style>
</head>
<body>
  <nav class="navbar navbar-expand-lg navbar-dark">
  <div class="container-fluid">
    <a class="navbar-brand" href="home.asp"><img src="../assets/images/logo.png" width="180" padding="3%"></a>
    <button class="navbar-toggler" type="button" data-bs-toggle="collapse" data-bs-target="#navbarColor01" aria-controls="navbarColor01" aria-expanded="false" aria-label="Toggle navigation">
      <span class="navbar-toggler-icon"></span>
    </button>
    <div class="collapse navbar-collapse" id="navbarColor01">
      <ul class="navbar-nav me-auto">
        <li class="nav-item">
          <a class="nav-link active" href="guest.asp">Home
            <span class="visually-hidden">(current)</span>
          </a>
        </li>
        <li class="nav-item dropdown">
          <a class="nav-link dropdown-toggle" data-bs-toggle="dropdown" href="#" role="button" aria-haspopup="true" aria-expanded="false">Account</a>
          <div class="dropdown-menu">
            <a class="dropdown-item" href="../index.html">Login</a>
            <a class="dropdown-item" href="../sign.html">Sign Up</a>
          </div>
        </li>
      </ul>
      
    </div>
  </div>
</nav>
<div class="container">