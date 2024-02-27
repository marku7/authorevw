<!--#include file="./templates/dbConnection.asp"-->

<%
	dim uid
	uid = request.querystring("id")

	sql="UPDATE posts SET tag = 0 WHERE postid=" & request.querystring("id")

	on error resume next
	cn.Execute sql

	if err<>0 then
		response.write ("No update permissions!")
		response.write err.description
	else
		response.redirect("mycontents.asp")
	end if

cn.close
%>