<!--#include file="./templates/dbconnection.asp"-->
<%
Dim description, owner, base64, category, genre, tag

description = Request.Form("description")
owner = Session("uid")
base64 = Request.Form("base64")
category = Request.Form("category")
genre = Request.Form("genre")
tag = "1" 

sql = "INSERT INTO posts (description, owner, category, genre, image, upvote, downvote, tag) VALUES ('" & description & "', '" & owner & "', '" & category & "', '" & genre & "', '" & base64 & "', '0', '0', " & tag & ")"

On Error Resume Next
cn.Execute sql, recaffected

If Err <> 0 Then
	Response.Write("No update permissions!")
	Response.Write(Err.Description)
Else
	'Response.Write("<h3>" & recaffected & " record added</h3>")
	Response.Redirect("home.asp")
End If

cn.Close
%>
