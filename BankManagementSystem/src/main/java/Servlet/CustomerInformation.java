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

public class CustomerInformation extends HttpServlet {
    public void init(ServletConfig config) throws ServletException{
        super.init(config);
    }
    public void service(HttpServletRequest request,
                        HttpServletResponse response)throws ServletException, IOException {
        request.setCharacterEncoding("utf-8");
        Connection con = null;
        PreparedStatement sql = null;
        Information informationBean = new Information();
        request.setAttribute("informationBean", informationBean);
        String logname = request.getParameter("logname").trim();
        if (logname == null) {
            logname = "";
        }
        String backNews = "";
        try {
            Context context = new InitialContext();
            Context contextNeeded = (Context)context.lookup("java:comp/env");
            DataSource ds = (DataSource)contextNeeded.lookup("bankdbsConn");
            con = ds.getConnection();
            String condition = "SELECT * FROM CustomerInfo WHERE Customer_ID='"+logname+"'";

            sql = con.prepareStatement(condition);
            ResultSet rs = sql.executeQuery(condition);
            boolean m = rs.next();
            if (m==true){
                informationBean.setId(rs.getString("Customer_ID"));
                informationBean.setRealname(rs.getString("Customer_Name"));
                informationBean.setPid(rs.getString("Customer_PID"));
                informationBean.setPhone(rs.getString("Customer_Telephone"));

            }
            condition = "SELECT * FROM BankcardInfo WHERE Customer_ID='"+logname+"'";
            sql = con.prepareStatement(condition);
            rs = sql.executeQuery(condition);
            m = rs.next();
            if (m==true){
                informationBean.setBankcardid(rs.getString("Bankcard_ID"));
                informationBean.setBalance(rs.getString("Bankcard_Balance"));
            }
            con.close();
        } catch (SQLException e) {
            backNews = "该用户名已经被使用，请您更换名字" + e;
            informationBean.setBackNews(backNews);
        } catch (NamingException e) {
            backNews = "没有设置连接池" + e;
            informationBean.setBackNews(backNews);
        } finally {
            try {
                con.close();
            } catch (Exception e) {
            }
        }
        RequestDispatcher dispatcher = request.getRequestDispatcher("CustomerInformation.jsp");
        dispatcher.forward(request,response);           //转发
    }
}
