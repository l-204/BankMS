<%--
  Created by IntelliJ IDEA.
  User: L204
  Date: 2023/6/24
  Time: 14:41
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<jsp:useBean id="userBean" class="JavaBean.Register" scope="request"/>
<html>
<head>
    <title>注册界面</title>
    <link rel="stylesheet" href="CSS/register.css">
</head>
<body>
    <div class="main">
        <div class="registerbox">
            <h3>注册账号</h3>
            <form action="CustomerRegisterServlet" method="post">
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

                <div class="password">
                    <em class="iconfont icon-suo"></em>
                    <input type="password" name="again_password" placeholder="请输入重复密码" autocomplete="off">
                </div>
                <label>请输入重复密码</label>

                <div class="email">
                    <em class="iconfont icon-xinfeng"></em>
                    <input type="text" name="realname" placeholder="请输入真实姓名" autocomplete="off">
                </div>
                <label>请输入真实姓名</label>

                <div class="email">
                    <em class="iconfont icon-xinfeng"></em>
                    <input type="text" name="pid" placeholder="请输入身份证号" autocomplete="off">
                </div>
                <label>请输入身份证号</label>

                <div class="email">
                    <em class="iconfont icon-xinfeng"></em>
                    <input type="text" name="phone" placeholder="请输入联系电话" autocomplete="off">
                </div>
                <label>请输入联系电话</label>

                <br>
                <input type="submit" value="注册" class="registerbtn">
                <p class="hint">
                    已有账号？<a href="CustomerLogin.jsp">&nbsp;去登录</a>
                </p>
            </form>
            <div align="center">
                注册反馈：
                <jsp:getProperty name="userBean" property="backNews"/>
            </div>
        </div>
    </div>
</body>
</html>
