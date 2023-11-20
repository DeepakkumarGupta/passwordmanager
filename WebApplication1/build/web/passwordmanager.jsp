<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@page import="java.sql.*,java.io.*"%>
<%@page import="javax.servlet.http.*,javax.servlet.*"%>
<%@page import="java.util.logging.Level, java.util.logging.Logger"%>

<%
    String username = null;

    // Check if the user is logged in
    HttpSession userSession = request.getSession();
    if (session.getAttribute("username") == null) {
        // Redirect to the login page if not logged in
        response.sendRedirect("login.jsp");
    } else {
        // User is logged in, retrieve the username
        username = (String) userSession.getAttribute("username");

        try {
            Class.forName("com.mysql.jdbc.Driver");
            Connection con = DriverManager.getConnection("jdbc:mysql://localhost:3306/password_manager?characterEncoding=UTF-8", "root", "");

            String selectQuery = "SELECT website, password FROM passwords WHERE user_id = (SELECT id FROM users WHERE username=?)";
            PreparedStatement selectStmt = con.prepareStatement(selectQuery);
            selectStmt.setString(1, username);
            ResultSet resultSet = selectStmt.executeQuery();
%>
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

        header {
            background-color: #007bff;
            color: #fff;
            padding: 10px;
            text-align: center;
            display: flex;
            justify-content: space-between;
            align-items: center;
        }

        header h1 {
            margin: 0;
        }

        header a {
            color: #fff;
            text-decoration: none;
        }

        form {
            width: 300px;
            margin: 50px auto;
            padding: 20px;
            background: #fff;
            border-radius: 8px;
            box-shadow: 0 4px 6px rgba(0, 0, 0, 0.1);
        }

        label {
            display: block;
            margin-bottom: 5px;
        }

        input[type="text"],
        input[type="password"] {
            width: 100%;
            padding: 10px;
            margin-bottom: 15px;
            border: 1px solid #ccc;
            border-radius: 4px;
            box-sizing: border-box;
        }

        button {
            width: 100%;
            padding: 10px;
            border: none;
            border-radius: 4px;
            background-color: #007bff;
            color: #fff;
            cursor: pointer;
            margin-bottom: 10px;
        }

        button:hover {
            background-color: #0056b3;
        }

        table {
            width: 50%;
            margin: 20px auto;
            border-collapse: collapse;
        }

        th, td {
            padding: 10px;
            border: 1px solid #ddd;
            text-align: left;
        }
    </style>

    <script>
        function togglePassword() {
            var passwordInput = document.getElementById("password");
            var passwordVisibilityToggle = document.getElementById("passwordVisibilityToggle");

            if (passwordInput.type === "password") {
                passwordInput.type = "text";
                passwordVisibilityToggle.innerText = "Hide Password";
            } else {
                passwordInput.type = "password";
                passwordVisibilityToggle.innerText = "Show Password";
            }
        }

        function generatePassword() {
            var length = 12; // Change the length of the generated password as needed
            var charset = "abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789!@#$%^&*()_-+=";

            var password = "";
            for (var i = 0; i < length; i++) {
                var randomIndex = Math.floor(Math.random() * charset.length);
                password += charset.charAt(randomIndex);
            }

            document.getElementById("password").value = password;
        }
    </script>
</head>
<body>
    <header>
        <h1>Password Manager</h1>
        <div>
            <span>Welcome, <%= username %></span>
            <a href="logout.jsp">Logout</a>
        </div>
    </header>

    <div>
        <form action="passwordmanager" method="post">
            <label for="url">Website URL</label>
            <input type="text" placeholder="Enter Website URL" name="url" id="url" required>

            <label for="password">Password</label>
            <input type="password" placeholder="Enter Password" name="password" id="password" required>
            <button type="button" id="passwordVisibilityToggle" onclick="togglePassword()">Show Password</button>
            <button type="button" onclick="generatePassword()">Generate Password</button>

            <input type="submit" value="Save Password">
        </form>

        <table>
            <thead>
                <tr>
                    <th>Website URL</th>
                    <th>Password</th>
                    <th>Actions</th>
                </tr>
            </thead>
            <tbody>
                <%
                    while (resultSet.next()) {
                        String website = resultSet.getString("website");
                        String password = resultSet.getString("password");
                %>
                            <tr>
                                <td><%= website %></td>
                                <td><%= password %></td>
                                <td><form action="DeletePasswordServlet" method="post">
                <input type="hidden" name="website" value="<%= website %>">
                <input type="submit" value="Delete">
            </form></td>
            
        </td>
                            </tr>
                <%
                    }

                    // Close resources
                    resultSet.close();
                    selectStmt.close();
                    con.close();
                } catch (Exception e) {
                    out.println("Error: " + e.getMessage());
                }
                %>
            </tbody>
        </table>
    </div>
</body>
</html>
<%
    }
%>
