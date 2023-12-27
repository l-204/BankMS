<%--
  Created by IntelliJ IDEA.
  User: L204
  Date: 2023/6/24
  Time: 18:05
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<jsp:useBean id="saveBean" class="JavaBean.Information" scope="request"/>
<html>
<head>
    <title>取款界面</title>
    <link rel="stylesheet" href="CSS/login.css">
</head>
<body>
    <div class="main">
        <div class="registerbox">
            <h3>取款</h3>
            <%String logname = request.getParameter("logname");%>
            <form action="CustomerTakeServlet?logname=<%=logname%>" method="post">
                <div class="email">
                    <em class="iconfont icon-xinfeng"></em>
                    <input type="text" name="balance" placeholder="请输入取出资金数目" autocomplete="off">
                </div>
                <label>请输入取出资金数目</label>

                <div class="email">
                    <em class="iconfont icon-xinfeng"></em>
                    <input type="text" name="bankcardID" placeholder="请输入银行卡号" autocomplete="off">
                </div>
                <label>请输入银行卡号</label>

                <div class="password">
                    <em class="iconfont icon-suo"></em>
                    <input type="password" name="password" placeholder="请输入银行卡密码" autocomplete="off">
                </div>
                <label>请输入银行卡密码</label>

                <div class="password">
                    <em class="iconfont icon-suo"></em>
                    <input type="text" name="address" placeholder="请输入您当前所在城市" autocomplete="off">
                </div>
                <label>请输入您当前所在城市</label>

                <br>
                <input type="submit" value="取款" class="registerbtn">
                <p class="hint">
                    不想取款？<a href="Customer.jsp">&nbsp;试试其他业务</a>
                </p>
            </form>
        </div>
    </div>
</body>
</html>
