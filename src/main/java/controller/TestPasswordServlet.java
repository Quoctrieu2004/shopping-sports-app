    package controller;

    import java.io.IOException;
    import jakarta.servlet.ServletException;
    import jakarta.servlet.http.HttpServlet;
    import jakarta.servlet.http.HttpServletRequest;
    import jakarta.servlet.http.HttpServletResponse;
    import data.utils.API;

    /**
     * Servlet test để kiểm tra việc mã hóa password
     * @author ASUS
     */
    public class TestPasswordServlet extends HttpServlet {

        @Override
        protected void doGet(HttpServletRequest request, HttpServletResponse response) 
                throws ServletException, IOException {

            response.setContentType("text/html;charset=UTF-8");

            try {
                // Test các password khác nhau
                String[] testPasswords = {"123", "Trieu2004", "Tai123", "test123", "password"};

                response.getWriter().println("<!DOCTYPE html>");
                response.getWriter().println("<html>");
                response.getWriter().println("<head>");
                response.getWriter().println("<title>Password Hash Test</title>");
                response.getWriter().println("<meta charset='UTF-8'>");
                response.getWriter().println("</head>");
                response.getWriter().println("<body>");
                response.getWriter().println("<h1>Password Hash Test Results</h1>");
                response.getWriter().println("<table border='1' style='border-collapse: collapse; width: 100%;'>");
                response.getWriter().println("<tr><th>Plain Password</th><th>MD5 Hash</th><th>Length</th></tr>");

                for (String password : testPasswords) {
                    String hash = API.getMd5(password);
                    response.getWriter().println("<tr>");
                    response.getWriter().println("<td>" + password + "</td>");
                    response.getWriter().println("<td>" + hash + "</td>");
                    response.getWriter().println("<td>" + hash.length() + "</td>");
                    response.getWriter().println("</tr>");
                }

                response.getWriter().println("</table>");
                response.getWriter().println("<br>");
                response.getWriter().println("<p><strong>Test đăng nhập:</strong></p>");
                response.getWriter().println("<p>Password '123' -> Hash: " + API.getMd5("123") + "</p>");
                response.getWriter().println("<p>Password 'Trieu2004' -> Hash: " + API.getMd5("Trieu2004") + "</p>");
                response.getWriter().println("<p>Password 'Tai123' -> Hash: " + API.getMd5("Tai123") + "</p>");

                response.getWriter().println("<br>");
                response.getWriter().println("<p><a href='home'>Go to Home</a></p>");
                response.getWriter().println("</body>");
                response.getWriter().println("</html>");

            } catch (Exception e) {
                response.getWriter().println("<!DOCTYPE html>");
                response.getWriter().println("<html>");
                response.getWriter().println("<head>");
                response.getWriter().println("<title>Test Error</title>");
                response.getWriter().println("<meta charset='UTF-8'>");
                response.getWriter().println("</head>");
                response.getWriter().println("<body>");
                response.getWriter().println("<h1>Test Error!</h1>");
                response.getWriter().println("<p>Error: " + e.getMessage() + "</p>");
                response.getWriter().println("<p><a href='home'>Go to Home</a></p>");
                response.getWriter().println("</body>");
                response.getWriter().println("</html>");

                e.printStackTrace();
            }
        }

        @Override
        protected void doPost(HttpServletRequest request, HttpServletResponse response) 
                throws ServletException, IOException {
            doGet(request, response);
        }
    }
