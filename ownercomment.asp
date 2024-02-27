<!--#include file="./templates/dbConnection.asp"-->
<!--#include file="./templates/header.asp"-->

<link rel="stylesheet" href="./assets/css/comment.css">
<link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap@5.0.0-alpha1/dist/css/bootstrap.min.css">
<link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap@5.0.0-alpha1/dist/js/bootstrap.bundle.min.js">
<link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/jquery/3.2.1/jquery.min.js">
<link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/4.7.0/css/font-awesome.min.css">
<style>
  .name-link {
    text-decoration: none;
    color: inherit;
  }
</style>
<%
Dim id
id = Request.QueryString("id")

set rs = Server.CreateObject("adodb.recordset")
rs.Open "SELECT COUNT(*) AS total_comments FROM comments WHERE postid=" & id, cn

Dim total_comments
total_comments = rs("total_comments")
rs.Close
Set rs = Nothing

%>

<div class="container mt-5 mb-5">
    <div class="row height d-flex justify-content-center align-items-center">
      <div class="col-md-7">
        <div class="card">
          <div class="p-3">
            <a href="javascript:history.back()">
            <img src="./assets/images/back.png" height="40px" alt="" style="margin-left: 10px;" title="Go back"></a>
            <h6 style="margin-top: 10px;"><%= total_comments %> Comment/s</h6>
          </div>

          <%
          set rs = Server.CreateObject("adodb.recordset")
          rs.Open "SELECT comments.comment_no, comments.comment, comments.commentdate, profiles.complete_name, profiles.userid, profiles.photo FROM comments INNER JOIN posts ON comments.postid = posts.postid INNER JOIN profiles ON comments.user_owner = profiles.userid WHERE comments.postid=" & id &" ORDER BY commentdate DESC", cn
      
          do until rs.eof
            Dim photo, name
            photo = rs("photo")
            name = rs("complete_name")

            response.write "<div class='mt-2'>"
            response.write "<div class='d-flex flex-row p-3'>"
              response.write "<a href='visit.asp?id=" & rs.fields("userid") & "'><img src='" & photo & "' width='40' height='40' class='rounded-circle mr-3'></a>"
            response.write "<div class='w-100'>"
                response.write "<div class='d-flex justify-content-between align-items-center'>"
                  response.write "<div class='d-flex flex-row align-items-center'>"
                    response.write "<small class='c-badge'><a class='name-link' href='visit.asp?id=" & rs.fields("userid") & "'>" & name & "</a></small>"
                    response.write "</div>"  
                    response.write "<div class='d-flex flex-row align-items-center'>"
                    response.write "<small><i>" & rs.fields("commentdate") & "</i></small>"
                    response.write "<a href='deletecomment.asp?id=" & rs.fields("comment_no") & "' title='Remove comment' style='margin-left: 5px;'><img src='./assets/images/remove.png' alt=''></a>"
                    response.write "</div>"
                    response.write "</div>"                    
            response.write "<p class='text-justify comment-text mb-0'>"& rs.fields("comment")&"</p>"
            response.write "<div class='d-flex flex-row user-feed'>"
            response.write "</div>"
            response.write "</div>"
            response.write "</div>"
            response.write "</div>"

            rs.movenext
          loop
          rs.close
          %>  
      </div>
    </div>
  </div>
</div>
