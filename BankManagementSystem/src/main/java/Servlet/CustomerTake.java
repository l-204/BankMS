package Servlet;

import JavaBean.Information;
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

public class CustomerTake extends HttpServlet {
    public void init(ServletConfig config) throws ServletException{
        super.init(config);
    }
    public void service(HttpServletRequest request,
                        HttpServletResponse response)throws ServletException, IOException {
        request.setCharacterEncoding("utf-8");
        Connection con = null;
        PreparedStatement sql = null;
        Information saveBean = new Information();
        request.setAttribute("saveBean",saveBean);
        String logname = request.getParameter("logname").trim();
        String balance = request.getParameter("balance").trim();
        String bankcardID = request.getParameter("bankcardID").trim();
        String password = request.getParameter("password").trim();
        String address = request.getParameter("address").trim();
        if (balance == null) {
            balance = "";
        }
        if (password == null) {
            password = "";
        }

        boolean boo = balance.length() > 0 && password.length() > 0;
        String backNews = "";
        try {
            Context context = new InitialContext();
            Context contextNeeded = (Context)context.lookup("java:comp/env");
            DataSource ds = (DataSource)contextNeeded.lookup("bankdbsConn");
            con = ds.getConnection();
            String condition = "UPDATE BankDBS.BankcardInfo SET Bankcard_Balance = Bankcard_Balance - '"+balance+
                                    "'WHERE Bankcard_ID ='"+bankcardID+"'" ;
            sql = con.prepareStatement(condition);
            if (boo) {
                if (sql.executeUpdate() != 0) {
                    String selectCondition = " SELECT Branch_Name FROM BankDBS.BranchInfo WHERE Branch_City='"+address+"'";
                    sql = con.prepareStatement(selectCondition);
                    ResultSet rs = sql.executeQuery();
                    rs.next();
                    address = rs.getString("Branch_Name");

                    String Condition = " INSERT INTO BankDBS.ServiceInfo VALUES(?,2,?,?,NOW(),' ')";
                    sql = con.prepareStatement(Condition);
                    sql.setString(1, bankcardID);
                    sql.setString(2, balance);
                    sql.setString(3, address);
                    sql.executeUpdate();

                    condition = "UPDATE BankDBS.BranchInfo SET Branch_Asset = Branch_Asset - '"+balance+
                            "'WHERE Branch_City='"+address+"'";
                    sql = con.prepareStatement(condition);
                    sql.executeUpdate();

//                    String updateCondition = "UPDATE BankDBS.BranchInfo SET Branch_Asset = Branch_Asset - '"+balance+
//                                "'WHERE Branch_City='"+address+"'";
//                    sql = con.prepareStatement(updateCondition);

                }
            } else {
                backNews = "信息填写不完整或者名字中有非法字符";
                saveBean.setBackNews(backNews);
            }
            con.close();
        } catch (SQLException e) {
            backNews = "" + e;
            saveBean.setBackNews(backNews);
        } catch (NamingException e) {
            backNews = "没有设置连接池" + e;
            saveBean.setBackNews(backNews);
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
