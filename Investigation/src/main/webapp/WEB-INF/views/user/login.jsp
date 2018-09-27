<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>Insert title here</title>
</head>
<body>
	<form action="/user/loginPost" method="POST">
		<div>
			<lable for="userid">아이디</lable>
			<input type="text" name="name" id="name" placeholder="아이디"/>
		</div>
		<div>
			<lable for="userpass">암호</lable>
			<input type="password" name="empno" id="empno" placeholder="암호"/>
		</div>
		<div>
			<input type="submit" value="로그인" />
		</div>
	</form>
</body>
</html>