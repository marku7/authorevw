<!--#include file="./templates/dbconnection.asp"-->
<%
dim base64, pid

base64 = Request.Form("base64")
pid = request.querystring("id")

sql = "UPDATE posts SET image = '" & base64 & "' WHERE postid = " & pid

On Error Resume Next
cn.Execute sql, recaffected

If Err <> 0 Then
	Response.Write("No update permissions!")
	Response.Write Err.Description
Else
	Response.Redirect("mycontents.asp")
End If

cn.Close
%>
