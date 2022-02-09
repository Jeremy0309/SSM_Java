<%@ page language="java" contentType="text/html; charset=UTF-8"
         pageEncoding="UTF-8"%>
<!DOCTYPE html>

<%
    String path = request.getContextPath();
    String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
    String url = basePath+"admin/login.jsp"; //设置跳转的地址
%>
<html>
<head>
    <meta charset="utf-8" http-equiv=refresh content=3;url=<%=url %>>
    <title>注册界面</title>
</head>
<body >
<b style=color:blue>注册成功！<span id=jump>3</span> 秒钟后页面将自动返回登录页面...</b>
</body>
</html>

<script>
    function countDown(secs){
        jump.innerText=secs;
        if(--secs>0)
            setTimeout("countDown("+secs+" )",1000);
    }
    countDown(3);
</script>