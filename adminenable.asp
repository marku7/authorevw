<!--#include file="./templates/dbConnection.asp"-->
<%
	dim uid
	uid = request.querystring("id")

	sql = "UPDATE profiles SET status = 1 WHERE userid=" & uid
	
	on error resume next
	cn.Execute sql

	if err<>0 then
		response.write ("No update permissions!")
		response.write err.description
	else
		response.redirect("accounts.asp")
	end if

cn.close
%>

