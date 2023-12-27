<%@ page import="java.sql.Connection" %>
<%@ page import="java.sql.DriverManager" %>
<%@ page import="java.sql.Statement" %>
<%@ page import="java.sql.ResultSet" %>
<%@ page import="static java.lang.System.out" %>
<%@ page import="static java.lang.System.out" %>
<%@ page import="static java.lang.System.*" %>
<%@ page import="static java.lang.System.*" %>
<%@ page import="static java.lang.System.*" %>
<%@ page import="static java.lang.System.*" %>
<%--
  Created by IntelliJ IDEA.
  User: L204
  Date: 2023/6/24
  Time: 17:25
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<jsp:useBean id="informationBean" class="JavaBean.Information" scope="request"/>
<html>
<head>
    <title>管理分行界面</title>
    <link rel="stylesheet" href="CSS/table.css">
</head>
<body>
    <%
        try{
            Class.forName("com.mysql.jdbc.Driver");
            Connection con = DriverManager.getConnection("jdbc:mysql://localhost:3306/BankDBS","root","1234");
            Statement sql = con.createStatement();
            ResultSet rs = sql.executeQuery("SELECT * FROM BranchInfo");

    %>
    <table>
        <caption>分行信息表</caption>
        <thead>
        <tr>
            <th>分行名称</th>
            <th>分行城市</th>
            <th>分行资产</th>
        </tr>
        </thead>
        <tbody>

    <%
        while (rs.next()) {
            out.print("<tr>");
            out.print("<td>"+rs.getString("Branch_Name")+"</td>");
            out.print("<td>"+rs.getString("Branch_City")+"</td>");
            out.print("<td>"+rs.getString("Branch_Asset")+"</td>");
            out.print("</tr>");
            }
        out.print("</tbody>");
        con.close();
        }catch (Exception e){
            out.print("连接失败"+e);
        }
    %>

        <tfoot>
        <tr>
            <td colspan="3"></td>
        </tr>
        </tfoot>
    </table>
</body>
</html>
