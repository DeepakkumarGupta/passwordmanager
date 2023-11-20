<%@page contentType="text/html" pageEncoding="UTF-8"%>


<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Password Manager</title>
    
        <style>
            body {
                margin: 0;
                padding: 0;
                font-family: 'Segoe UI', Tahoma, Geneva, Verdana, sans-serif;
                background-color: #f9f9f9;
                color: #333;
            }
    
            .container {
                width: 80%;
                margin: 0 auto;
                padding: 20px;
            }
    
            nav ul {
                list-style: none;
                padding: 0;
                margin: 0;
                background-color: #444;
                text-align: center;
                display: flex;
                justify-content: center;
                align-items: center;
                height: 70px;
                border-radius: 8px;
                box-shadow: 0 2px 4px rgba(0, 0, 0, 0.1);
            }
    
            nav ul li {
                margin: 0 10px;
            }
    
            nav ul li a {
                text-decoration: none;
                color: #fff;
                padding: 10px 15px;
                transition: background-color 0.3s;
            }
    
            nav ul li a:hover {
                background-color: #555;
                border-radius: 4px;
            }
    
            /* Additional styling for the content section */
            .content {
                margin-top: 30px;
                padding: 20px;
                background-color: #fff;
                border-radius: 8px;
                box-shadow: 0 2px 4px rgba(0, 0, 0, 0.1);
            }
        </style>
    </head>
<body>
    <div>
        <h2>Welcome to the Password Manager</h2>
        <nav>
            <ul>
                <li><a href="login.jsp">Login</a></li>
                <li><a href="register.jsp">Register</a></li>
                 <li><a href="passwordmanager.jsp">password manager</a></li>
            </ul>
        </nav>
    </div>
   
</body>
</html>
