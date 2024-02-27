<!--#include file="./templates/dbconnection.asp"-->
<%
Dim comment, cid

comment = Request.Form("comment")
cid = Request.QueryString("id")

If comment <> "" And IsNumeric(cid) Then
    ' Sanitize the input to prevent SQL injection
    comment = Replace(comment, "'", "''")
    cid = CInt(cid)

    ' Update the comment in the database
    Dim sql
    sql = "UPDATE comments SET comment = '" & comment & "' WHERE comment_no = " & cid
    
    On Error Resume Next
    cn.Execute sql, recaffected
    
    If Err <> 0 Then
        Response.Write("An error occurred while updating the comment.")
        Response.Write("<br>")
        Response.Write(Err.Description)
    Else
        Response.Redirect("comment.asp?id=" & cid)
    End If
Else
    Response.Write("Invalid comment or comment ID.")
End If

cn.Close
%>
