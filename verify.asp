<!--#include file="./templates/dbconnection.asp"-->

<%
    Dim email
    Dim password
    
    email = Request.Form("email_address")
    password = Request.Form("pword")
    
    If email = "admin" And password = "root" Then
        Response.Redirect("admin.asp")
    Else
        Set rs = Server.CreateObject("adodb.recordset")
        rs.Open "SELECT * FROM profiles WHERE email_address='" & email & "' AND pword='" & password & "' ", cn

        If rs.EOF Then
            Response.Write "Login failed"
            Response.Write Err.Description
        Else
            Dim avatar
            avatar = rs("photo")
            i = i + 1
            Session("uid") = rs.Fields("userid")
            rs.MoveNext
        End If

        rs.Close
        cn.Close

        If i <> 0 Then
            Response.Redirect("home.asp")
        End If
    End If
%>
