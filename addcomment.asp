<!--#include file="./templates/dbconnection.asp"-->
<%
Dim comment, owner, postid
comment = Request.Form("comment")
owner = Session("uid")
postid = Request.QueryString("id")

sql = "INSERT INTO comments (comment, user_owner, postid) VALUES ('" & comment & "', '" & owner & "', '" & postid & "')"

On Error Resume Next
cn.Execute sql, recaffected

If Err <> 0 Then
    Response.Write("No update permissions!")
    Response.Write(Err.Description)
Else
    'Response.Write("<h3>" & recaffected & " record added</h3>")
    Response.Redirect("comment.asp?id=" & postid)
End If

cn.Close
%>
