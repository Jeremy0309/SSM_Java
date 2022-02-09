<%@ page language="java" contentType="text/html; charset=UTF-8"
pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>

	<head>
		<meta charset="UTF-8">
		<link rel="stylesheet" href="${pageContext.request.contextPath}/css/bootstrap.css" />
		<link rel="stylesheet" href="${pageContext.request.contextPath}/css/login.css" />
		<script type="text/javascript" src="${pageContext.request.contextPath}/js/jquery-3.3.1.js"></script>
		<script type="text/javascript" src="${pageContext.request.contextPath}/js/bootstrap.js"></script>
<%--		<script type="text/javascript" src="${pageContext.request.contextPath}/js/wx-validate.base.js"></script>--%>
		<title></title>
		
	</head>

	<body onload="createCode()">
		<div id="login" style="height: 600px;width: 600px">
			<div id="top" style="height: 20px;align-content: center">
				<img src="${pageContext.request.contextPath}/images/cloud.jpg"   />
				<span style="font-size: 30px">REGIST</span>
			</div>
			<div id="bottom" style="height: 400px">
				<form action="${pageContext.request.contextPath}/admin/regist" method="get" onsubmit="return checkSub()" >
					<table border="0px" id="table" >
						<tr >
							<td class="td1" style="font-size: 15px;">用户名：&nbsp;&nbsp;</td>
							<td >
								<input type="text" placeholder="" class="td2" name="aName" id="aName" onblur="checkaName()">

							</td>
						</tr>
						<tr>
							<td></td>
							<td><span id="aNameSpan"></span></td>
						</tr>
						<tr>
							<td class="td1" style="font-size: 15px;">密码：&nbsp;&nbsp;</td>
							<td>
								<input type="password" placeholder="" class="td2" id="aPass" name="aPass" onblur="checkaPass()">
							</td>
						</tr>
						<tr>
							<td></td>
							<td><span id="aPassSpan"></span></td>
						</tr>
						<tr>
							<td class="td1" style="font-size: 15px;">再次输入密码：&nbsp;&nbsp;</td>
<%--							<td >再次输入密码：</td>--%>
							<td>
								<input type="password" placeholder="" class="td2" id="pwd2" name="pwd2" onblur="checkPwd2()">
							</td>
						</tr>
						<tr>
							<td></td>
							<td><span id="pwd2Span"></span></td>
						</tr>
						<tr>
							<td class="td1" style="font-size: 15px;">邮箱：&nbsp;&nbsp;</td>
							<td>
								<input type="text"  class="td2" id="mail" name="mail" alt="mail" onblur="checkMail()">
							</td>
						</tr>
						<tr>
							<td></td>
							<td><span id="mailSpan"></span></td>
						</tr>

						<tr>
						<tr>
							<td class="td1" style="font-size: 15px;">验证码：&nbsp;&nbsp;</td>
							<td>
								<input type="text" id="code" value="" style="width:100px;" onblur="checkCode()" />&nbsp;&nbsp;&nbsp;
								<span id="codeSpan" style="background-image: url(${pageContext.request.contextPath}/images/bg.jpg);width:50px;color: black;" onclick="createCode()">
							</span>
							</td>
						</tr>
						<tr>
							<td></td>
							<td><span id="codeSpan2"></span></td>
						</tr>

						<tr>
							<td></td>
							<td><input type="submit" value="注册" class="td3">
								<a href="${pageContext.request.contextPath}/admin/login.jsp">
									<input type="button" value="取消"class="td3	">
								</a>
							</td>
						</tr>
					</table>
				</form>
			</div>

		</div>
	</body>
<script type="text/javascript" >
	//常见验证码
	function createCode(){
		//创建随机4位数字，math.floor向下取整
		var code=Math.floor(Math.random()*9000+1000);
		//获取元素对象
		var  span=document.getElementById("codeSpan");
		//将数字存放到span中
		span.innerHTML=code;
		//给span添加背景图片
	}

	//验证用户名
	function checkaName(){
		//获取用户获得用户名信息
		var aName=document.getElementById("aName").value;
		//创建校验规则,用户名6-12个 数字字母或下划线
		var reg=/^[a-zA-Z0-9_]{6,12}$/;
		//获取span对象
		var aNameSpan=document.getElementById("aNameSpan");
		//开始交验
		if(aName==""||aName==null){
			//输入校验结果
			show_invalid('#aName','error','*用户名不能为空','red');
			return false;
		}else if(reg.test(aName)){
			//输入校验结果
			checknameAjax();
			// aNameSpan.innerHTML="✔";//校验通过
			// aNameSpan.style.color="green";
			var res = $("#aName").parent().hasClass('has-success');
			// alert('success?'+res)
			if (res==true){
				return true;
			}else{
				return false;
			}
		}else{
			//输入校验结果
			// aNameSpan.innerHTML="*用户名格式不符"
			// aNameSpan.style.color="red";
			show_invalid('#aName','error','*用户名格式不符','red');
			return false;
		}
	}

	//验证密码
	function checkaPass(){
		//获取用户获得用户名信息
		var aPass=document.getElementById("aPass").value;
		//创建校验规则,密码要求6-2位
		var reg=/^[\w_]{6,12}$/;
		//获取span对象
		var span=document.getElementById("aPassSpan");
		//开始交验
		if(aPass==""||aPass==null){
			//输入校验结果
			show_invalid('#aPass','error','*密码不能为空','red');
			return false;
		}else if(reg.test(aPass)){
			//输入校验结果
			show_invalid('#aPass','success','✔','green');
			return true;
		}else{
			//输入校验结果
			show_invalid('#aPass','error','*密码格式不符','red');
			return false;
		}
		//第一次密码为a123456，第二次密码为a1234567，则修改的第一次密码，确认密码也会重新校验
		checkPwd2();
	}

	//校验确认密码
	function checkPwd2(){
		//获取第一次校验密码
		var pwd=document.getElementById("aPass").value;
		//获取确认密码
		var pwd2=document.getElementById("pwd2").value;
		//获取span对象
		var span=document.getElementById("pwd2Span");
		//比较前两次密码是否相同
		if( pwd2==""|| pwd2==null){
			//输入校验结果
			show_invalid('#pwd2','error','*密码不能为空','red');
			return false;
		}else if(pwd===pwd2){
			//输入校验结果
			show_invalid('#pwd2','success','✔','green');
			return true;
		}else{
			//输入校验结果
			show_invalid('#pwd2','error','*密码不一致，请重新输入','red');
			return false;
		}
	}

	//检查邮箱
	function checkMail(){
		return checkField("mail",/^[a-zA-Z0-9_-]+@[a-zA-Z0-9_-]+(\.[a-zA-Z0-9_-]+)+$/)
	}

	//封装校验：相同的保留，不同的传参
	function checkField(id,reg){
		//获取用户数据
		var inp=document.getElementById(id);
		var	va=inp.value;
		var	alt=inp.alt;
		//创建校验规则
		//获取span对象
		var span=document.getElementById(id+"Span");
		//开始校验
		if(va==""||va==null){
			//输入校验结果
			show_invalid('#'+id,'error','*'+alt+'不能为空','red');
			return false;
		}else if(reg.test(va)){
			//输入校验结果
			show_invalid('#'+id,'success','✔','green');
			return true;
		}else{
			//输入校验结果
			show_invalid('#'+id,'error','*'+alt+'格式不符','red');
			return false;
		}
	}

	//校验确认验证码------------------
	function checkCode(){
		//获取用户输入验证码
		var code=document.getElementById("code").value;
		//获取随机验证码
		var code2=document.getElementById("codeSpan").innerHTML;
		//获取span对象
		var span=document.getElementById("codeSpan2");
		//比较前两次密码是否相同
		if( code==""|| code==null){
			//输入校验结果
			span.innerHTML="*验证码不能为空"
			span.style.color="red";
			createCode();
			return false;
		}else if(code==code2){
			//输入校验结果
			span.innerHTML="✔"
			span.style.color="green";
			return true;
		}else{
			//输入校验结果
			//输入校验结果
			span.innerHTML="验证码错误"
			span.style.color="red";
			createCode();
			return false;
		}
	}

	function checkSub(){
		checkaName();
		checkaPass();
		checkPwd2();
		checkMail();
		checkCode();
		return checkaName()&&checkaPass()&&checkPwd2()&&checkMail()&&checkCode();
	}

	function checknameAjax(){
		var aName = $("#aName").val();
		// alert(aName);
		$.ajax({
			url:"${pageContext.request.contextPath}/admin/checkName",
			data:{"aName":aName},
			type:"POST",
			success:function (result){
				var str = result.extend.result;
				if(str=="success"){
					show_invalid('#aName','success','✔','green');
				}else{
					show_invalid('#aName','error','用户名不可用','red');
				}
			}
		});
	};
	//显示校验的信息的样式
	function show_invalid(id,status,info,style) {
		//当需要检验的时候，清空校验所在的css样式
		$(id).parent().removeClass('has-error has-success');
		$(id+'Span').text('');
		if('error' == status) {
			$(id).parent().addClass('has-error');
			$(id+'Span').text(info);
			$(id+'Span').css('color',style)
		}else if('success' == status) {
			$(id).parent().addClass('has-success');
			$(id+'Span').text(info);
			$(id+'Span').css('color',style)
		}
	}

</script>

</html>