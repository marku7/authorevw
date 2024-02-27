<!--#include file="./templates/dbConnection.asp"-->

<%
' Check if the user is logged in
If Session("uid") = "" Then
    Response.Redirect "login.asp" ' Redirect the user to the login page if not logged in
    Response.End
End If

' Get the values from the form
Dim postid, violation, others, owner
postid = Request.Form("postid")
violation = Request.Form("violation")
others = Request.Form("others")
owner = Session("uid")

' Check if the user has already reported this post
Dim rsReportCheck
Set rsReportCheck = Server.CreateObject("ADODB.Recordset")
rsReportCheck.Open "SELECT * FROM reports WHERE postid=" & postid & " AND submittedby='" & owner & "'", cn
If rsReportCheck.EOF Then ' If the user hasn't reported this post, insert the report into the database
    rsReportCheck.Close
    Set rsReportCheck = Nothing

    Dim sql
    If violation = "" Then
        ' Insert the report with 'others' as the reason
        sql = "INSERT INTO reports (reason, submittedby, postid) VALUES ('" & others & "', '" & owner & "', '" & postid & "')"
    ElseIf others = "" Then
        ' Insert the report with 'violation' as the reason
        sql = "INSERT INTO reports (reason, submittedby, postid) VALUES ('" & violation & "', '" & owner & "', '" & postid & "')"
    Else
        ' Insert the report with both 'violation' and 'others' as the reasons
        sql = "INSERT INTO reports (reason, submittedby, postid) VALUES ('" & violation & ", and " & others & "', '" & owner & "', '" & postid & "')"
    End If

    ' Execute the SQL query to insert the report
    cn.Execute sql

    ' Fetch the post owner's userid from the posts table based on the provided postid
    Dim postOwner
    Dim postOwnerRS
    Set postOwnerRS = Server.CreateObject("ADODB.Recordset")
    postOwnerRS.Open "SELECT owner FROM posts WHERE postid=" & postid, cn, 3, 3

    If Not postOwnerRS.EOF Then
        postOwner = postOwnerRS("owner").Value
        postOwnerRS.Close
        Set postOwnerRS = Nothing ' Release resources

        ' Update the post owner's reportcount in the profiles table
        Dim updateSQL
        updateSQL = "UPDATE profiles SET reportcount=reportcount + 1 WHERE userid='" & postOwner & "'"
        cn.Execute updateSQL
    End If

    ' Redirect the user back to the previous page or homepage
    Response.Redirect "home.asp" ' Change this to your desired redirect URL
Else ' If the user has already reported this post, show an error message or redirect back to the previous page
    Response.Write "You have already reported this post."
    ' Or, you can redirect back to the previous page using:
    ' Response.Redirect Request.ServerVariables("HTTP_REFERER")
End If
%>
