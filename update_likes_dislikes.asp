<%

' Retrieve the values sent from the client-side JavaScript
Dim postId, likeCount, dislikeCount
postId = Request.Form("postId")
likeCount = Request.Form("likeCount")
dislikeCount = Request.Form("dislikeCount")

On Error Resume Next

' Establish a database connection
Set conn = Server.CreateObject("ADODB.Connection")
conn.ConnectionString = "Driver={MySQL ODBC 5.3 UNICODE Driver}; Server=starryarizlovido.cmu-online.tech; Database=cmuonine_lovidosmadb; User=cmuon_lovidosm; Password=O4&3lqs7; Port=3306;"
conn.Open


If Err.Number <> 0 Then
    Response.Write "Database connection error: " & Err.Description
    Response.End
End If

' Retrieve the current likes and dislikes count from the database
sql = "SELECT upvote, downvote FROM posts WHERE postid=" & postId
Set rs = conn.Execute(sql)
If Not rs.EOF Then
    currentLikeCount = rs("upvote")
    currentDislikeCount = rs("downvote")
    rs.Close
    
    ' Check if the likeCount or dislikeCount has been incremented or decremented
    ' If so, update the database with the new values
    If likeCount <> currentLikeCount Or dislikeCount <> currentDislikeCount Then
        sql = "UPDATE posts SET upvote=" & likeCount & ", downvote=" & dislikeCount & " WHERE postid=" & postId
        conn.Execute sql
        
        If Err.Number <> 0 Then
            Response.Write "Database update error: " & Err.Description
        Else
            Response.Write "Database updated successfully"
        End If
    Else
        Response.Write "No changes to update"
    End If
Else
    rs.Close
    Response.Write "Post not found"
End If

' Close the database connection
conn.Close
Set conn = Nothing

On Error GoTo 0
%>
