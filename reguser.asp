<!--#include file="./templates/dbconnection.asp"-->
<%
dim cname, eaddress, pword, status

base64 = Request.form("base64")
cname= request.form("complete_name")
eaddress= request.form("email_address")
pword= request.form("pword")


sql="INSERT INTO profiles (complete_name, email_address, photo, pword, reportcount, status) VALUES (' " & cname & "','" & eaddress & "', '" & base64 & "', '" & pword & "', '0', 1)"

on error resume next
cn.Execute sql,recaffected

if err<>0 then
	Response.Write("No update permissions!")
	response.write err.description
else
	response.redirect("index.html")
end if

cn.close
%>