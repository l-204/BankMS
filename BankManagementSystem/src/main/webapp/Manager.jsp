<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html>
    <head>
        <title>交易员界面</title>
        <link rel="stylesheet" href="CSS/menu.css">
    </head>
    <body>
        <ul>
            <li><a href="ManagerRegister.jsp">注册</a></li>
            <li><a href="ManagerLogin.jsp">登录</a></li>
            <li class="dropdown">
                <a href="javascript:void(0)" class="dropbtn">业务办理</a>
                <div class="dropdown-content">
                    <a href="ManagerCustomer.jsp">管理客户</a>
                    <a href="ManagerBusiness.jsp">管理业务</a>
                    <a href="ManagerBranch.jsp">管理分行</a>
                    <a href="ManagerService.jsp">管理交易</a>
                    <a href="ManagerBankcard.jsp">管理银行卡</a>
                </div>
            </li>
            <li><a href="index.jsp">返回首页</a></li>
        </ul>
    </body>
</html>