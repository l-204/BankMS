package Servlet;

import JavaBean.Information;
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
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.Random;

public class CustomerOpen extends HttpServlet {
    public void init(ServletConfig config) throws ServletException{
        super.init(config);
    }
    public void service(HttpServletRequest request,
                        HttpServletResponse response)throws ServletException, IOException {
        request.setCharacterEncoding("utf-8");
        Connection con = null;
        PreparedStatement sql = null;
        Information openBean = new Information();
        request.setAttribute("openBean", openBean);
        String logname = request.getParameter("logname").trim();
        String realname = request.getParameter("realname").trim();
        String pid = request.getParameter("pid").trim();
        String address = request.getParameter("address").trim();
        String bankcardID = getRandom(19);
        if (realname == null) {
            realname = "";
        }
        if (pid == null) {
            pid = "";
        }

        boolean boo = realname.length() > 0 && pid.length() > 0;
        String backNews = "";
        try {
            Context context = new InitialContext();
            Context contextNeeded = (Context)context.lookup("java:comp/env");
            DataSource ds = (DataSource)contextNeeded.lookup("bankdbsConn");
            con = ds.getConnection();
            String insertCondition = " INSERT INTO BankDBS.BankcardInfo VALUES(?,?,888888,NOW(),0,0);";
            sql = con.prepareStatement(insertCondition);
            if (boo) {
                sql.setString(1, logname);
                sql.setString(2, bankcardID);
                int m = sql.executeUpdate();
                if (m != 0) {
                    String selectCondition = " SELECT Branch_Name FROM BankDBS.BranchInfo WHERE Branch_City='"+address+"'";
                    sql = con.prepareStatement(selectCondition);
                    ResultSet rs = sql.executeQuery();
                    rs.next();
                    address = rs.getString("Branch_Name");
                    String Condition = " INSERT INTO BankDBS.ServiceInfo VALUES(?,8,0,?,NOW(),' ')";
                    sql = con.prepareStatement(Condition);
                    sql.setString(1, bankcardID);
                    sql.setString(2, address);
                    m = sql.executeUpdate();

                }
            } else {
                backNews = "信息填写不完整或者名字中有非法字符";
                openBean.setBackNews(backNews);
            }
            con.close();
        } catch (SQLException e) {
            backNews = "一人仅限一个账户，请勿重复开户" + e;
            openBean.setBackNews(backNews);
        } catch (NamingException e) {
            backNews = "没有设置连接池" + e;
            openBean.setBackNews(backNews);
        } finally {
            try {
                con.close();
            } catch (Exception e) {
            }
        }
        RequestDispatcher dispatcher = request.getRequestDispatcher("Customer.jsp");
        dispatcher.forward(request,response);           //转发
    }
    public static String getRandom(int len) {
        Random r = new Random();
        StringBuilder rs = new StringBuilder();

        for (int i = 0; i < len; i++) {
            rs.append(r.nextInt(10));
        }
        return rs.toString();
    }
}
