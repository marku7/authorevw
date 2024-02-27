<!--#include file="./templates/header.asp"-->
<!--#include file="./templates/dbConnection.asp"-->


<%
set rs = server.createobject("adodb.recordset")
rs.open "SELECT * FROM profiles WHERE userid='" & Session("uid") & "'", cn

Dim profilepic, user
profilepic = rs.fields("photo")
user = rs.fields("complete_name")


%>

<link href="https://maxcdn.bootstrapcdn.com/font-awesome/4.3.0/css/font-awesome.min.css" rel="stylesheet">
<link rel="stylesheet" type="text/css" href="./assets/css/mycontents.css">
<style>
.timeline-header {
display: flex;
align-items: center;
}
.timeline-header .actions {
margin-left: auto;
display: flex;
align-items: center;
}
.timeline-header .actions img {
margin-left: 5px;
}
</style>
<div class="container">
<div class="row">
<div class="col-md-12">
   <div id="content" class="content content-full-width">
      <div class="profile">
         <div class="profile-header">
            <div class="profile-header-cover"></div>
            <div class="profile-header-content">
               <div class="profile-header-img">
                 <%
                 if profilepic = "" then
                  response.write "<img src='./assets/images/default.png' alt=''>"
                 else
                  response.write "<img src='" & profilepic & "' alt=''>"
                 
                  end if
                 %>
               </div>
               <div class="profile-header-info">
                  <h4 class="m-t-10 m-b-5" style="color: black;"><%response.write(rs.fields("complete_name"))%></h4>
                  <% response.write "<a href='newpost.asp?id=" & rs.fields("userid") & "' title='Edit the user account' class='btn btn-sm btn-info mb-2'>Add Post</a>" %>
               </div>
            </div>
            <ul class="profile-header-tab nav nav-tabs">
               <li class="nav-item"><a href="profile.asp" class="nav-link_">PROFILE</a></li>
            </ul>
         </div>
      </div>
      <div class="profile-content">
         <div class="tab-content p-0">
            <div class="tab-pane fade active show" id="profile-post">
               <%
                  set rs = server.createobject("adodb.recordset")
                  rs.open "SELECT * FROM posts WHERE owner='" & Session("uid") & "' ORDER BY date_created DESC", cn
                  do until rs.eof
                     Dim photo_base64, avatar
                     photo_base64 = rs("image")
                     

                     response.write "<ul class='timeline'>"
                     response.write "<div>"
                     response.write "<div class='timeline-body'>"
                     response.write "<div class='timeline-header'>"

                    
                     response.write "<span class='userimage'><img src='" & profilepic & "' alt=''></span>"
                     response.write "<span class='username'>" & user & "<small></small></span>"
                     response.write "<div class='actions'>"
                     response.write "<div><a href='ownercomment.asp?id=" & rs.fields("postid") & "' title='View comments'><img src='./assets/images/comment.png' width='30' height='30'></a></div>"
                     response.write "<a href='editpost.asp?id=" & rs.fields("postid") & "' title='Edit post'><img src='./assets/images/edit.png' alt=''></a>"
                     response.write "<a href='editimage.asp?id=" & rs.fields("postid") & "' title='Edit post image'><img src='./assets/images/img.png' alt=''></a>"

                     if rs.fields("tag") = 0 then
                         response.write "<a href='show.asp?id=" & rs.fields("postid") & "' title='Show post'><img src='./assets/images/hide.png' alt=''></a>"
                     else    
                        response.write "<a href='hide.asp?id=" & rs.fields("postid") & "' title='Hide post'><img src='./assets/images/show.png' alt=''></a>"
                     end if

                     response.write "<a href='delete.asp?id=" & rs.fields("postid") & "' title='Delete post'><img src='./assets/images/delete.png' alt=''></a>"
                     response.write "</div>"
                     response.write "</div>"
                     response.write "<div class='timeline-content'>"
                     response.write "<span><b>" & rs.fields("category") & " | " & rs.fields("genre") & "</b></span>"
                     response.write "<h6>" & rs.fields("description") & "</h6>"
                     response.write "</div>"
                     response.write "<div class='timeline-content'>"
                     response.write "<img src='" & photo_base64 & "' alt='' class='post-img' />"
                     response.write "</div>"
                     response.write "</div>"
                     response.write "</div>"
                     response.write "</ul>"

                     rs.movenext
                  loop
                  rs.close
               %>
            </div>
         </div>
      </div>
   </div>
</div>
</div>
</div>

<!--#include file="./templates/footer.asp"-->
