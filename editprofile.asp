<!--#include file="./templates/dbConnection.asp"-->
<!--#include file="./templates/header.asp"-->
<link rel="stylesheet" href="assets/css/edit.css"/> 

<%
' Get user id from query string
Dim pid
pid = Request.QueryString("id")

' Check if form has been submitted
If Request.Form("submit") <> "" Then

    ' Get form data
    dim complete_name, email_address, pword, aboutme, gender
    complete_name = Request.Form("complete_name")
    email_address = Request.Form("email_address")
    pword = Request.Form("pword")
    aboutme = Request.Form("aboutme")
    gender = Request.Form("gender")

    ' Open recordset for updating user information
    Set rs = Server.Createobject("ADODB.Recordset")
    rs.Open "SELECT * FROM profiles WHERE userid=" & pid, cn, 3, 3

    ' Update user information
    rs.Fields("complete_name") = complete_name
    rs.Fields("email_address") = email_address
    rs.Fields("pword") = pword
    rs.Fields("aboutme") = aboutme
    rs.Fields("gender") = gender

    rs.Update

    ' Close recordset
    rs.Close

    ' Redirect to view user page after editing
    Response.Redirect("profile.asp?uid=" & id)
Else
    ' Open recordset for displaying user information
    set rs = server.createobject("ADODB.Recordset")
    rs.open "SELECT * FROM profiles WHERE userid=" & pid, cn

    ' Display form for editing user information
    Response.write "<div class='form-wrapper'>"
    Response.write "<div class='signup-box'>"
    Response.write "<h1>Edit Account</h1>"
    Response.write "<form method='post'>"
    Response.write "<label>Full Name</label>"
    Response.write "<input type='text' name='complete_name' value='" & rs.fields("complete_name") &"'/>"
    Response.write "<label>Email</label>"
    Response.write "<input type='email' name='email_address' value='" & rs.fields("email_address") &"' />"
    Response.write "<label>Password</label>"
    Response.write "<input type='password' name='pword' value='" & rs.fields("pword") &"'/>"
    Response.write "<label>About Me</label>"
    Response.write "<input type='text' name='aboutme' value='" & rs.fields("aboutme") &"'/>"

    Response.Write "<fieldset class='form-group'>"
      Response.Write "<legend class='mt-4' style='text-align: center;'>Gender</legend>"
  
      Dim genderValue
      genderValue = rs.Fields("gender").Value
  
      Response.Write "<div class='form-check'>"
      Response.Write "<input class='form-check-input' type='radio' name='gender' id='optionsRadios1' value='Male'"
      If genderValue = "Male" Then
          Response.Write " checked"
      End If
      Response.Write ">"
      Response.Write "<label class='form-check-label' for='optionsRadios1'>Male</label>"
      Response.Write "</div>"
  
      Response.Write "<div class='form-check'>"
      Response.Write "<input class='form-check-input' type='radio' name='gender' id='optionsRadios2' value='Female'"
      If genderValue = "Female" Then
          Response.Write " checked"
      End If
      Response.Write ">"
      Response.Write "<label class='form-check-label' for='optionsRadios2'>Female</label>"
      Response.Write "</div>"
  
      Response.Write "<div class='form-check'>"
      Response.Write "<input class='form-check-input' type='radio' name='gender' id='optionsRadios3' value='Others'"
      If genderValue = "Others" Then
          Response.Write " checked"
      End If
      Response.Write ">"
      Response.Write "<label class='form-check-label' for='optionsRadios3'>Others</label>"
      Response.Write "</div>"
      Response.Write "</fieldset>"

    Response.write "<input type='submit' name='submit' value='Save'>"
    Response.Write "<a href='profile.asp'><input type='button' value='Cancel' ></a>"
    Response.write "</form>"
    response.write "<P></p>"
    Response.write "</div>"
    Response.write "</div>"

    ' Close recordset
    rs.Close
End If
%>
