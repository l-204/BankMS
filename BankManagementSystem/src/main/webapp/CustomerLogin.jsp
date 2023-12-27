<%--
  Created by IntelliJ IDEA.
  User: L204
  Date: 2023/6/24
  Time: 16:10
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<jsp:useBean id="loginBean" class="JavaBean.Login" scope="session"/>
<jsp:useBean id="userBean" class="JavaBean.Information" scope="request"/>
<html>
<head>
    <title>登录界面</title>
    <link rel="stylesheet" href="CSS/login.css">
</head>
<body>
    <div class="main">
        <div class="registerbox">
            <h3>登录账号</h3>
            <form action="CustomerLoginServlet" method="post">
                <div class="email">
                    <em class="iconfont icon-xinfeng"></em>
                    <input type="text" name="logname" placeholder="请输入用户名" autocomplete="off">
                </div>
                <label>请输入用户名/用户名格式为8位字母、数字、下划线组合</label>

                <div class="password">
                    <em class="iconfont icon-suo"></em>
                    <input type="password" name="password" placeholder="请输入密码" autocomplete="off">
                </div>
                <label>请输入密码/密码格式为6位字母、数字、下划线组合</label>

                <br>
                <input type="submit" value="登录" class="registerbtn">
                <p class="hint">
                    还没账号？<a href="CustomerRegister.jsp">&nbsp;去注册</a>
                </p>
            </form>
            <div align="center">
                登陆反馈信息：
                <jsp:getProperty name="loginBean" property="backNews"/>
            </div>
        </div>
    </div>
</body>
</html>
