package Servlet;

import JavaBean.Login;
import jakarta.servlet.RequestDispatcher;
import jakarta.servlet.ServletConfig;
import jakarta.servlet.ServletException;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

import javax.naming.Context;
import javax.naming.InitialContext;
import javax.naming.NamingException;
import javax.sql.DataSource;
import java.io.IOException;
import java.io.PrintWriter;
import java.sql.Connection;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;

public class CustomerLogin extends HttpServlet {
    public void init(ServletConfig config) throws ServletException{
        super.init(config);
    }
    public void service(HttpServletRequest request,
                        HttpServletResponse response)
                        throws ServletException, IOException {
        request.setCharacterEncoding("utf-8");
        Connection con = null;
        Statement sql;
        String logname = request.getParameter("logname").trim(),
                password = request.getParameter("password").trim();
//        password = Encrypt.encrypt(password,"java.jsp");                    //给用户密码加密
        boolean boo = (logname.length()>0)&&(password.length()>0);
        try{
            Context context = new InitialContext();
            Context contextNeeded = (Context)context.lookup("java:comp/env");
            DataSource ds = (DataSource)contextNeeded.lookup("bankdbsConn");    //获得连接池
            con = ds.getConnection();                                                //使用连接池中的连接
            String condition = "select * from CustomerInfo where Customer_ID = '" +
                    logname + "'and Customer_Password = '" + password + "'";
            sql = con.createStatement();
            if (boo){
                ResultSet rs = sql.executeQuery(condition);
                boolean m = rs.next();
                if (m==true){
                    //调用登录成功的方法
                    success(request,response,logname,password);
                    RequestDispatcher dispatcher = request.getRequestDispatcher("Customer.jsp");   //转发
                    dispatcher.forward(request,response);
                }
                else {
                    String backNews = "您输入的用户名不存在，或密码不匹配";
                    //调用登录失败的方法
                    fail(request,response,logname,backNews);
                }
            }
            else {
                String backNews = "请输入用户名和密码";
                fail(request,response,logname,backNews);
            }
            con.close();                        //连接返回连接池
        } catch (SQLException e) {
            String backNews = ""+e;
            fail(request,response,logname,backNews);
        } catch (NamingException e) {
            String backNews = "没有设置连接池"+e;
            fail(request,response,logname,backNews);
        }
        finally {
            try{
                con.close();
            }
            catch (Exception e){}
        }
    }
    public void success(HttpServletRequest request,
                        HttpServletResponse response,
                        String logname,String password) {
        Login loginBean = null;
        HttpSession session = request.getSession(true);
        try {
            loginBean = (Login) session.getAttribute("loginBean");
            if (loginBean == null) {
                loginBean = new Login();        //创建新的数据模型
                session.setAttribute("loginBean", loginBean);
                loginBean = (Login) session.getAttribute("loginBean");
            }
            String name = loginBean.getLogname();
            if (name.equals(logname)) {
                loginBean.setBackNews("成功登录用户" + logname);
                loginBean.setLogname(logname);
            } else {
                loginBean.setBackNews("成功登录用户" + logname);
                loginBean.setLogname(logname);
            }
        } catch (Exception e) {
            loginBean = new Login();
            session.setAttribute("loginBean", loginBean);
            loginBean.setBackNews(e.toString());
            loginBean.setLogname(logname);
        }
    }
    public void fail(HttpServletRequest request,
                     HttpServletResponse response,
                     String logname,String backNews){
        response.setContentType("text/html;charset=utf-8");
        try{
            HttpSession session = request.getSession(true);
            Login loginBean = (Login) session.getAttribute("loginBean");
            loginBean.setBackNews(backNews);
            RequestDispatcher dispatcher = request.getRequestDispatcher("CustomerLogin.jsp");   //转发
            dispatcher.forward(request,response);
        } catch (IOException e){} catch (ServletException e) {
            throw new RuntimeException(e);
        }
    }
}
