<!--#include file="./templates/dbConnection.asp"-->
<%
	dim uid
	uid = request.querystring("id")

	sql = "DELETE FROM comments WHERE comment_no=" & uid

	on error resume next
	cn.Execute sql

	if err<>0 then
		response.write ("No update permissions!")
		response.write err.description
	else
	Response.Redirect Request.ServerVariables("HTTP_REFERER")
	end if

    rs.close
cn.close
set rs = Nothing
%>