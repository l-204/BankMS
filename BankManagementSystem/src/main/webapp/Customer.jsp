<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html>
    <head>
        <title>客户界面</title>
        <link rel="stylesheet" href="CSS/menu.css">
    </head>
    <body>
        <%String logname = request.getParameter("logname");%>
        <ul>
            <li><a href="CustomerRegister.jsp">注册</a></li>
            <li><a href="CustomerLogin.jsp">登录</a></li>
            <li class="dropdown">
                <a href="javascript:void(0)" class="dropbtn">业务办理</a>
                <div class="dropdown-content">
                    <a href="CustomerOpen.jsp?logname=<%=logname%>">我要开户</a>
                    <a href="CustomerSave.jsp?logname=<%=logname%>">我要存款</a>
                    <a href="CustomerTake.jsp?logname=<%=logname%>">我要取款</a>
                    <a href="CustomerInformationServlet?logname=<%=logname%>">我的信息</a>
                </div>
            </li>
            <li><a href="index.jsp">返回首页</a></li>
        </ul>
    </body>
</html>