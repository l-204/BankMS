package Servlet;

import JavaBean.Register;
import jakarta.servlet.RequestDispatcher;
import jakarta.servlet.ServletConfig;
import jakarta.servlet.ServletException;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

import javax.naming.Context;
import javax.naming.InitialContext;
import javax.naming.NamingException;
import javax.sql.DataSource;
import java.io.IOException;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.SQLException;

public class ManagerRegister extends HttpServlet {
    public void init(ServletConfig config) throws ServletException{
        super.init(config);
    }
    public void service(HttpServletRequest request,
                        HttpServletResponse response)throws ServletException, IOException {
        request.setCharacterEncoding("utf-8");
        Connection con = null;
        PreparedStatement sql = null;
        Register userBean = new Register();
        request.setAttribute("userBean", userBean);
        String logname = request.getParameter("logname").trim();
        String password = request.getParameter("password").trim();
        String again_password = request.getParameter("again_password").trim();
        String realname = request.getParameter("realname").trim();
        String address = request.getParameter("address").trim();
        String phone = request.getParameter("phone").trim();
        if (logname == null) {
            logname = "";
        }
        if (password == null) {
            password = "";
        }
        if (!password.equals(again_password)) {
            userBean.setBackNews("两次密码不同，注册失败");
            RequestDispatcher dispatcher = request.getRequestDispatcher("ManagerRegister.jsp");
            dispatcher.forward(request, response);       //转发
            return;
        }
        boolean isLD = true;
        for (int i = 0; i < logname.length(); i++) {
            char c = logname.charAt(i);
            if (!(Character.isLetterOrDigit(c) || c == '_')) {
                isLD = false;
            }
        }
        boolean boo = logname.length() > 0 && password.length() > 0 && isLD;
        String backNews = "";
        try {
            Context context = new InitialContext();
            Context contextNeeded = (Context)context.lookup("java:comp/env");
            DataSource ds = (DataSource)contextNeeded.lookup("bankdbsConn");
            con = ds.getConnection();
            String insertCondition = "INSERT INTO ManagerInfo VALUES(?,?,?,?,?)";
            sql = con.prepareStatement(insertCondition);
            if (boo) {
                sql.setString(1, logname);
//                password = Encrypt.encrypt(password, "javajsp");
                sql.setString(2, password);
                sql.setString(3, realname);
                sql.setString(4, address);
                sql.setString(5, phone);
                int m = sql.executeUpdate();
                if (m != 0) {
                    backNews = "注册成功";
                    userBean.setBackNews(backNews);
                    userBean.setLogname(logname);
                    userBean.setRealname(realname);
                    userBean.setPid(address);
                    userBean.setPhone(phone);
                }
            } else {
                backNews = "信息填写不完整或者名字中有非法字符";
                userBean.setBackNews(backNews);
            }
            con.close();
        } catch (SQLException e) {
            backNews = "该编号已注册或请您检查所在分行是否有误" + e;
            userBean.setBackNews(backNews);
        } catch (NamingException e) {
            backNews = "没有设置连接池" + e;
            userBean.setBackNews(backNews);
        } finally {
            try {
                con.close();
            } catch (Exception e) {
            }
        }
        RequestDispatcher dispatcher = request.getRequestDispatcher("Manager.jsp");
        dispatcher.forward(request,response);           //转发
    }
}
