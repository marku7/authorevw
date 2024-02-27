<!--#include file="./templates/dbConnection.asp"-->
<!--#include file="./templates/header.asp"-->

<link rel="stylesheet" href="./assets/css/comment.css">
<link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap@5.0.0-alpha1/dist/css/bootstrap.min.css">
<link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/4.7.0/css/font-awesome.min.css">
<style>
  .modal-footer .btn-secondary {
    color: black;
  }
  .name-link {
    text-decoration: none;
    color: inherit;
  }

</style>

<%
Dim id
id = Request.QueryString("id")

' Check if form has been submitted to add a new comment
If Request.Form("comment") <> "" Then
    Dim newComment
    newComment = Request.Form("comment")
    
    ' Insert the new comment into the database
    cn.Execute "INSERT INTO comments (comment, postid, user_owner) VALUES ('" & Replace(newComment, "'", "''") & "', " & id & ", " & Session("uid") & ")"
End If

' Retrieve the total number of comments for the post
Dim rs
Set rs = Server.CreateObject("ADODB.Recordset")
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
          <div class="mt-3 d-flex flex-row align-items-center p-3 form-color">
            <img src="<%= Session("avatar") %>" width="50" class="rounded-circle mr-2">
            <form method="post" action="addcomment.asp?id=<%= id %>" class="d-flex w-100">
              <textarea class="form-control" name="comment" placeholder="Enter your comment..." style="width: 100%;"></textarea>
              <button class="post-button">Post</button>
            </form>
          </div> 

          <%
          set rs = Server.CreateObject("adodb.recordset")
          rs.Open "SELECT comments.comment_no, comments.comment, comments.commentdate, profiles.complete_name, profiles.userid, profiles.photo, comments.user_owner FROM comments INNER JOIN posts ON comments.postid = posts.postid INNER JOIN profiles ON comments.user_owner = profiles.userid WHERE comments.postid=" & id &" ORDER BY commentdate DESC", cn
      
          do until rs.eof
            Dim photo, name, user
            photo = rs("photo")
            name = rs("complete_name")
            user = Session("uid")
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
                  
                  ' Check if the user is the owner of the comment
                  if rs.fields("user_owner") = user Then
                    response.write "<a href='javascript:void(0)' class='edit-comment' data-toggle='modal' data-target='#editCommentModal' data-commentid='" & rs.fields("comment_no") & "' title='Edit comment' style='margin-left: 5px;'><img src='./assets/images/ed.png' alt=''></a>"
                    response.write "<a href='deletecomment.asp?id=" & rs.fields("comment_no") & "' title='Remove comment' style='margin-left: 5px;'><img src='./assets/images/remove.png' alt=''></a>"
                  else
                    response.write ""
                  end if
                response.write "</div>"
              response.write "</div>" 
                
              response.write "<p class='text-justify comment-text mb-0' id='comment-" & rs.fields("comment_no") & "'>"& rs.fields("comment") &"</p>"
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

<!-- Edit Comment Modal -->
<div class="modal fade" id="editCommentModal" tabindex="-1" role="dialog" aria-labelledby="editCommentModalLabel" aria-hidden="true">
  <div class="modal-dialog" role="document">
    <div class="modal-content">
      <div class="modal-header">
        <h5 class="modal-title" id="editCommentModalLabel">Edit Comment</h5>
        <button type="button" class="close" data-dismiss="modal" aria-label="Close">
          <span aria-hidden="true">&times;</span>
        </button>
      </div>
      <div class="modal-body">
        <form id="editCommentForm" method="post" action="editcomment.asp">
          <textarea class="form-control" name="comment" id="editCommentText" placeholder="Enter your updated comment..." style="width: 100%;"></textarea>
          <input type="hidden" name="comment_id" id="editCommentId">
        </form>
      </div>
      <div class="modal-footer">
        <button type="button" class="btn btn-secondary" data-dismiss="modal">Cancel</button>
        <button type="button" class="btn btn-primary" name="submit" id="saveCommentChanges">Save Changes</button>
      </div>
    </div>
  </div>
</div>

<script src="https://cdnjs.cloudflare.com/ajax/libs/jquery/3.2.1/jquery.min.js"></script>
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.0.0-alpha1/dist/js/bootstrap.bundle.min.js"></script>
<script>
  $(document).ready(function() {
    var commentId;
    
    $('.edit-comment').click(function() {
      commentId = $(this).data('commentid');
      var commentText = $('#comment-' + commentId).text();
      $('#editCommentText').val(commentText);
      $('#editCommentId').val(commentId);
    });
    
    $('#saveCommentChanges').click(function() {
      var editedComment = $('#editCommentText').val();
      $.post('editcomment.asp?id=' + commentId, { comment: editedComment })
        .done(function() {
          location.reload();
        });
    });
  });
</script>

<%
' Close the database connection
cn.Close
Set cn = Nothing

%>

<!--#include file="./templates/footer.asp"-->
