<!--#include file="./templates/dbconnection.asp"-->
<!--#include file="./templates/header.asp"-->

<style>
    .activity-icons button {
		background: none;
		border: none;
		padding: 0;
		cursor: pointer;
	}

	.activity-icons button img {
		width: 30px;
		height: 30px;
	}

	.activity-icons {
  display: flex;
  align-items: center;
}

.activity-icons button,
.activity-icons span,
.activity-icons div {
  margin-right: 10px;
}

.post-container .activity-icons div:last-child {
  margin-right: 0;
}

    .back-to-top {
  position: fixed;
  bottom: 20px;
  right: 20px;
  display: none;
  z-index: 9999;
}

.back-to-top img {
  width: 40px;
  height: 40px;
}

/* Show the button when scrolling */
body.scrollTop-show .back-to-top,
html.scrollTop-show .back-to-top {
  display: block;
}

</style>

<a href="#" class="back-to-top">
    <img src="./assets/images/top.png" alt="Back to Top" />
  </a>
  

<div class="container">
    <div class="row">
        <div class="col-md-12">
            <link href="https://maxcdn.bootstrapcdn.com/font-awesome/4.3.0/css/font-awesome.min.css" rel="stylesheet">
            <link rel="stylesheet" type="text/css" href="./assets/css/mycontents.css">

            <%
            Dim id, user, profilepic
            id = Request.QueryString("id")
            
            set rs = server.createobject("adodb.recordset")
            rs.open "SELECT * FROM profiles WHERE userid='" & id & "'", cn
            
            user = rs.fields("complete_name")
            profilepic = rs.fields("photo")
            %>
            
            <div class="container">
                <div class="row">
                    <div class="col-md-12">
                        <div id="content" class="content content-full-width">
                            <div class="profile">
                                <div class="profile-header">
                                    <div class="profile-header-cover"></div>
                                    <div class="profile-header-content">
                                        <div class="profile-header-img">
                                            <img src="<%= profilepic %>" alt="">
                                        </div>
                                        <div class="profile-header-info">
                                            <h4 class="m-t-10 m-b-5"><%response.write(rs.fields("complete_name"))%></h4>
                                        </div>
                                    </div>
                                </div>
                            </div>

                            <div class="profile-content">
                                <div class="tab-content p-0">
                                    <div class="tab-pane fade in active show" id="profile-about">
                                        <div class="table-responsive">
                                            <table class="table table-profile">
                                                <thead>
                                                    <tr>
                                                        <th></th>
                                                        <th>
                                                            <h4><%response.write(rs.fields("complete_name"))%></h4>
                                                        </th>
                                                    </tr>
                                                </thead>
                                                <tbody>
                                                    <tr>
                                                        <td class="field">Gender</td>
                                                        <td><p><%response.write(rs.fields("gender"))%></p></td>
                                                    </tr>
                                                    <tr>
                                                        <td class="field">Email Address</td>
                                                        <td><p><%response.write(rs.fields("email_address"))%></p></td>
                                                    </tr>
                                                    
                                                    <tr class="divider">
                                                        <td colspan="2"></td>
                                                    </tr>
                                                    <tr class="highlight">
                                                        <td class="field">About Me</td>
                                                        <td><p><%response.write(rs.fields("aboutme"))%></p></td>
                                                    </tr>
                                                </tbody>
                                            </table>
                                        </div>
                                    </div>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>
            </div>


        </div>
    </div>
</div>
<div class="container">
    <div class="row">
        <div class="col-md-12">
            <div id="content" class="content content-full-width">
                <div class="profile-content">
                    <div class="tab-content p-0">
                        <div class="tab-pane fade active show" id="profile-post">
                            <%
                            set rs = server.createobject("adodb.recordset")
                            rs.open "SELECT * FROM posts WHERE owner='" & id & "' ORDER BY date_created DESC", cn
                            do until rs.eof
                                Dim photo_base64, pid
                                photo_base64 = rs("image")
                                pid = rs("postid")

                                response.write "<ul class='timeline'>"
                                response.write "<div>"
                                response.write "<div class='timeline-body'>"
                                response.write "<div class='timeline-header'>"
                                response.write "<span class='userimage'><img src='" & profilepic & "' alt=''></span>"
                                response.write "<span class='username'>" & user & "<small></small></span>"
                                response.write "</div>"
                                response.write "<div class='timeline-content'>"
                                response.write "<span><b>" & rs.fields("category") & " | " & rs.fields("genre") & "</b></span>"
                                response.write "<h6>" & rs.fields("description") & "</h6>"
                                response.write "</div>"
                                response.write "<div class='timeline-content'>"
                                response.write "<img src='" & photo_base64 & "' alt='' class='post-img' />"
                                response.write "</div>"
                                response.write "<div class='post-row'>" 
                                    response.write "<div class='activity-icons'>"
                                        Response.Write "<button onclick=""upvote(" & rs.fields("postid") & "); location.reload();"">"
                                        Response.Write "<img src='./assets/images/like.png' width='30' height='30'>"
                                        Response.Write "</button>"

                                        Response.Write "<div class='upvote' id='upvote-" & rs.fields("postid") & "'>&nbsp; "& rs.fields("upvote") &"</div>"

                                        Response.Write "<button onclick=""downvote(" & rs.fields("postid") & "); location.reload();"">"
                                        Response.Write "<img src='./assets/images/dislike.png' width='30' height='30'>"
                                        Response.Write "</button>"
                                        
                                        Response.Write "<div class='downvote' id='downvote-" & rs.fields("postid") & "'>&nbsp; "& rs.fields("downvote")&"</div>"  
                                        
                                        dim cr
                                        Set cr = Server.CreateObject("ADODB.Recordset")
                                        cr.Open "SELECT COUNT(*) AS total_comments FROM comments WHERE postid=" & pid, cn

                                        Dim total_comments
                                        total_comments = cr("total_comments")
                                        cr.Close
                                        Set cr = Nothing

                                        response.write "<div class='comments'><a href='comment.asp?id=" & rs.fields("postid") & "'><img src='./assets/images/comment.png' width='30' height='30' title='Add comment'></a></div>"
                                        response.write "<div class='total-comments'>&nbsp; "& total_comments &"</div>"
                                      
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

<script>

    // Add event listener to show/hide the button when scrolling
		window.addEventListener("scroll", function() {
		var backToTopBtn = document.querySelector(".back-to-top");
		if (window.scrollY > 500) {
			backToTopBtn.style.display = "block";
		} else {
			backToTopBtn.style.display = "none";
		}
		});

		// Add smooth scrolling behavior when clicking the button
		document.querySelector(".back-to-top").addEventListener("click", function(e) {
		e.preventDefault();
		window.scrollTo({
			top: 0,
			behavior: "smooth"
		});
		});

		// end

    	function upvote(postId) {
	// Send an AJAX request to update the upvote count in the database
	const xhr = new XMLHttpRequest();
	xhr.open('POST', 'upvote.asp');
	xhr.setRequestHeader('Content-Type', 'application/x-www-form-urlencoded');
	xhr.onreadystatechange = function() {
		if (xhr.readyState === 4 && xhr.status === 200) {
		// Success! Update the upvote count on the page
		const upvoteElement = document.getElementById(`upvote-${postId}`);
		if (upvoteElement) {
			upvoteElement.innerText = parseInt(upvoteElement.innerText) + 1;
		}
		}
	};
	xhr.send('postId=' + postId);
	}

	function downvote(postId) {
	// Send an AJAX request to update the upvote count in the database
	const xhr = new XMLHttpRequest();
	xhr.open('POST', 'downvote.asp');
	xhr.setRequestHeader('Content-Type', 'application/x-www-form-urlencoded');
	xhr.onreadystatechange = function() {
		if (xhr.readyState === 4 && xhr.status === 200) {
		// Success! Update the upvote count on the page
		const downvoteElement = document.getElementById(`downvote-${postId}`);
		if (downvoteElement) {
			downvoteElement.innerText = parseInt(downvoteElement.innerText) + 1;
		}
		}
	};
	xhr.send('postId=' + postId);
	}
</script>
<!--#include file="./templates/footer.asp"-->
