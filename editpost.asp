<!--#include file="./templates/dbConnection.asp"-->
<!--#include file="./templates/header.asp"-->

<%
' Get user id from query string
    Dim pid
    pid = Request.QueryString("id")

' Check if form has been submitted
    If Request.Form("submit") <> "" Then

' Get form data
    dim description, category, genre
    description = Request.Form("description")
    category = Request.Form("category")
    genre = Request.Form("genre")

' Open recordset for updating user information
    Set rs = Server.Createobject("ADODB.Recordset")
    rs.Open "SELECT * FROM posts WHERE postid=" & pid, cn, 3, 3

' Update user information
    rs.Fields("description") = description
    rs.Fields("category") = category
    rs.Fields("genre") = genre
    rs.Update

' Close recordset
    rs.Close

' Redirect to view user page after editing
    Response.Redirect("mycontents.asp?uid=" & id)
    Else
' Open recordset for displaying user information
    set rs = server.createobject("ADODB.Recordset")
    rs.open "SELECT * FROM posts WHERE postid=" & pid, cn

' Display form for editing user information
    Response.Write "<div class='container'>"
    Response.Write "<div class='row justify-content-center'>"
    Response.Write "<div class='col-md-6'>"
    Response.Write "<h1 class='text-center'>Edit Post</h1>"
    Response.Write "<form method='post'>"
    Response.Write "<table>"

    Response.Write "<tr>"
        Response.Write "<td>Description: &nbsp;</td>"
        Response.Write "<td><input name='description' value='"  & rs.Fields("description") & "' style='width: 500px;'></input></td>"
    Response.Write "</tr>"
    
    Response.Write "<tr>"
        Response.Write "<td>&nbsp;</td>"
        Response.Write "<td>"
        Response.Write "<fieldset class='form-group'>"
        Response.Write "<legend class='mt-4' style='text-align: center;'>Category</legend>"
    
        Dim categoryValue
        categoryValue = rs.Fields("category").Value
    
        Response.Write "<div class='form-check'>"
        Response.Write "<input class='form-check-input' type='radio' name='category' id='optionsRadios1' value='Book'"
        If categoryValue = "Book" Then
            Response.Write " checked"
        End If
        Response.Write ">"
        Response.Write "<label class='form-check-label' for='optionsRadios1'>Book</label>"
        Response.Write "</div>"
    
        Response.Write "<div class='form-check'>"
        Response.Write "<input class='form-check-input' type='radio' name='category' id='optionsRadios2' value='Movie'"
        If categoryValue = "Movie" Then
            Response.Write " checked"
        End If
        Response.Write ">"
        Response.Write "<label class='form-check-label' for='optionsRadios2'>Movie</label>"
        Response.Write "</div>"
    
        Response.Write "<div class='form-check'>"
        Response.Write "<input class='form-check-input' type='radio' name='category' id='optionsRadios3' value='Short Story'"
        If categoryValue = "Short Story" Then
            Response.Write " checked"
        End If
        Response.Write ">"
        Response.Write "<label class='form-check-label' for='optionsRadios3'>Short Story</label>"
        Response.Write "</div>"
    
        Response.Write "</fieldset>"
        Response.Write "</td>"
        Response.Write "</tr>"

        Response.Write "<tr>"
            Response.Write "<td>&nbsp;</td>"
            Response.Write "<td>"
            Response.Write "<fieldset class='form-group'>"
            Response.Write "<legend class='mt-4' style='text-align: center;'>Genre</legend>"
        
            Dim genreValue
            genreValue = rs.Fields("genre").Value
        
            Response.Write "<div class='form-check'>"
            Response.Write "<input class='form-check-input' type='radio' name='genre' id='optionsRadios1' value='Action'"
            If genreValue = "Action" Then
                Response.Write " checked"
            End If
            Response.Write ">"
            Response.Write "<label class='form-check-label' for='optionsRadios1'>Action</label>"
            Response.Write "</div>"
        
            Response.Write "<div class='form-check'>"
            Response.Write "<input class='form-check-input' type='radio' name='genre' id='optionsRadios2' value='Comedy'"
            If genreValue = "Comedy" Then
                Response.Write " checked"
            End If
            Response.Write ">"
            Response.Write "<label class='form-check-label' for='optionsRadios2'>Comedy</label>"
            Response.Write "</div>"
        
            Response.Write "<div class='form-check'>"
            Response.Write "<input class='form-check-input' type='radio' name='genre' id='optionsRadios3' value='Drama'"
            If genreValue = "Drama" Then
                Response.Write " checked"
            End If
            Response.Write ">"
            Response.Write "<label class='form-check-label' for='optionsRadios3'>Drama</label>"
            Response.Write "</div>"

            Response.Write "<div class='form-check'>"
                Response.Write "<input class='form-check-input' type='radio' name='genre' id='optionsRadios3' value='Romance'"
                If genreValue = "Romance" Then
                    Response.Write " checked"
                End If
                Response.Write ">"
                Response.Write "<label class='form-check-label' for='optionsRadios3'>Romance</label>"
                Response.Write "</div>"
        
                Response.Write "<div class='form-check'>"
                    Response.Write "<input class='form-check-input' type='radio' name='genre' id='optionsRadios3' value='Horror'"
                    If genreValue = "Horror" Then
                        Response.Write " checked"
                    End If
                    Response.Write ">"
                    Response.Write "<label class='form-check-label' for='optionsRadios3'>Horror</label>"
                    Response.Write "</div>"
                
                Response.Write "<div class='form-check'>"
                        Response.Write "<input class='form-check-input' type='radio' name='genre' id='optionsRadios3' value='Fantasy'"
                        If genreValue = "Fantasy" Then
                            Response.Write " checked"
                        End If
                        Response.Write ">"
                        Response.Write "<label class='form-check-label' for='optionsRadios3'>Fantasy</label>"
                        Response.Write "</div>"

                Response.Write "<div class='form-check'>"
                            Response.Write "<input class='form-check-input' type='radio' name='genre' id='optionsRadios3' value='Thrill'"
                            If genreValue = "Thrill" Then
                                Response.Write " checked"
                            End If
                            Response.Write ">"
                            Response.Write "<label class='form-check-label' for='optionsRadios3'>Thrill</label>"
                            Response.Write "</div>"
            Response.Write "</fieldset>"
            Response.Write "</td>"
            Response.Write "</tr>"
            
           
    Response.Write "</table>"
    Response.write "<div class='text-center'>"
    Response.Write "<br><input type='submit' class='btn btn-primary' name='submit' value='Save'>"
    Response.Write "&nbsp;"
    Response.Write "<a href='mycontents.asp'><input type='button' class='btn btn-primary' value='Cancel'></a>"
    Response.write "</div> "
    Response.Write "</form>"
    Response.write "</div>"
    Response.write "</div>"
    Response.write "</div>"

    

' Close recordset
    rs.Close
    End If
%>
