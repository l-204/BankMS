<%--
  Created by IntelliJ IDEA.
  User: L204
  Date: 2023/6/24
  Time: 18:05
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<jsp:useBean id="openBean" class="JavaBean.Information" scope="request"/>
<html>
<head>
    <title>开户界面</title>
    <link rel="stylesheet" href="CSS/login.css">
</head>
<body>
    <div class="main">
        <div class="registerbox">
            <h3>新建账户</h3>
            <%String logname = request.getParameter("logname");%>
            <form action="CustomerOpenServlet?logname=<%=logname%>" method="post">
                <div class="email">
                    <em class="iconfont icon-xinfeng"></em>
                    <input type="text" name="realname" placeholder="请输入真实姓名" autocomplete="off">
                </div>
                <label>请输入您的真实姓名</label>

                <div class="password">
                    <em class="iconfont icon-suo"></em>
                    <input type="text" name="pid" placeholder="请输入身份证号" autocomplete="off">
                </div>
                <label>请输入您的身份证号</label>

                <div class="password">
                    <em class="iconfont icon-suo"></em>
                    <input type="text" name="address" placeholder="请输入您当前所在城市" autocomplete="off">
                </div>
                <label>请输入您当前所在城市</label>

                <br>
                <input type="submit" value="开户" class="registerbtn">
                <p class="hint">
                    已有账户？<a href="Customer.jsp">&nbsp;试试其他业务</a>
                </p>
            </form>
        </div>
    </div>
</body>
</html>
