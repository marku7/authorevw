	<!--#include file="./templates/dbConnection.asp"-->
	<!DOCTYPE html>
	<html>
	<head>
		<meta charset="utf-8">
		<meta name="viewport" content="width=device-width, initial-scale=1">
		<link rel="stylesheet" type="text/css" href="./assets/css/home.css">
		<link rel="stylesheet" type="text/css" href="./assets/css/mycontents.css">
		<script src="./assets/js/vote.js"></script>
		
		<title>AuthoRevw</title>
		<style>
	.image-upload-container input[type="file"] {
	display: none;
	}

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
.post-container a {
    text-decoration: none;
}


.right-sidebar a {
    text-decoration: none;
}

		</style>
	</head>
	<body style="background-color: #E6DCDC">

	<!--#include file="./templates/header.asp"-->

	<a href="#" class="back-to-top">
		<img src="./assets/images/top.png" alt="Back to Top" />
	  </a>
	  

	<div class="container">
		<div class="container">
			<div class="left-sidebar">
				<form method="get" action="home.asp" class="d-flex">
					<input class="form-control me-sm-2" type="search" name="txtSearch" placeholder="Search">
				</form>
				<div class="imp-links">
					<a href="home.asp">
						<button class="left-btn" style="background-color: #bbb5b5;">All</button><br>
					</a>
					<a href="home2.asp">
						<button class="left-btn">Books and Movies</button>
					</a>
					<a href="home3.asp">
						<button class="left-btn">Short Stories</button>
					</a>
				</div>

				<div class="form-group">
					<label for="genre">Genre: &nbsp;</label>
					<select name="genre" id="genre">
					<option value="">All</option>
					<option value="Action">Action</option>
					<option value="Comedy">Comedy</option>
					<option value="Drama">Drama</option>
					<option value="Romance">Romance</option>
					<option value="Horror">Horror</option>
					<option value="Fantasy">Fantasy</option>
					<option value="Thrill">Thrill</option>
					</select>
				</div>
			</div>
				<div class="main-content">
					<div class="write-post-container">
		<div class="user-profile">
			<%
			set rs=server.createobject("adodb.recordset")
			rs.open "SELECT * FROM profiles WHERE userid = '"& Session("uid") &"'", cn
			Dim profilepic, username
			profilepic = rs("photo")
			username = rs.fields("complete_name")

			if profilepic = "" then
				response.write "<p style='text-align:center;'><img src='./assets/images/default.png' class='img-circle' width='50px' height='50px'></p>"
			else 
				response.write "<p style='text-align:center;'><img src='" & profilepic & "' class='img-circle' width='50px' height='50px'></p>"
			end if
			rs.close
			
			%>
			<div>
				<p class="main-name"> <%= username %> </p>
			</div>
		</div>
		
		<div class="post-input-container">
			<form action="addpost.asp" method="post">
				<textarea rows="3" placeholder="Post a review" required name="description"></textarea>
				<div class="image-upload-container">
					<div id="custom-button" class="upload-button">
					<img src="./assets/images/upload.png" alt="">
					</div>
					<input type="file" id="photo" accept="image/*">
				</div>
				<div class="input-row">
					<div class="form-group">
					<label for="category">Category:</label>
					<select name="category" id="category">
						<option value="Book" selected>Book</option>
						<option value="Movie">Movie</option>
						<option value="Short Story">Short Story</option>
					</select>
					</div>
				<div class="form-group">
					<label for="genre">&nbsp;&nbsp; Genre:</label>
					<select name="genre" id="genre">
					<option value="Action" selected>Action</option>
					<option value="Comedy">Comedy</option>
					<option value="Drama">Drama</option>
					<option value="Romance">Romance</option>
					<option value="Horror">Horror</option>
					<option value="Fantasy">Fantasy</option>
					<option value="Thrill">Thrill</option>
					</select>
				</div>
				</div>
			
				<div class="image-preview-container">
					<img id="preview" src="#" alt="Image Preview" style="max-width: 100%; max-height: 200px; margin-top: 10px; display: none;">
				</div>
				<div class="form-group">
					<input type="hidden" id="base64" name="base64">
				</div>
				<div class="form-group" align="right">
					<button class="post-button">Post</button>
				</div>
			</form>
		</div>
	</div>

					<%
					Function HasReportedPost(postId)
					Dim rsReportCheck
					Set rsReportCheck = Server.CreateObject("ADODB.Recordset")
					rsReportCheck.Open "SELECT * FROM reports WHERE postid=" & postId & " AND submittedby='" & Session("uid") & "'", cn
					HasReportedPost = Not rsReportCheck.EOF
					rsReportCheck.Close
					Set rsReportCheck = Nothing
					End Function

					set rs = server.createobject("adodb.recordset")
					Dim filterBy
					filterBy = request.querystring("filter")

					Dim whereClause
					if filterBy = "Action" then
						whereClause = "WHERE genre = 'Action' AND tag = 1"
					elseif filterBy = "Comedy" then
						whereClause = "WHERE genre = 'Comedy' AND tag = 1"
					elseif filterBy = "Drama" then
						whereClause = "WHERE genre = 'Drama' AND tag = 1"
					elseif filterBy = "Romance" then
						whereClause = "WHERE genre = 'Romance' AND tag = 1"
					elseif filterBy = "Horror" then
						whereClause = "WHERE genre = 'Horror' AND tag = 1"
					elseif filterBy = "Fantasy" then
						whereClause = "WHERE genre = 'Fantasy' AND tag = 1"
					elseif filterBy = "Thrill" then
						whereClause = "WHERE genre = 'Thrill' AND tag = 1"
					else
						whereClause = "WHERE tag = 1"
					end if

					If Request.QueryString("txtSearch") = "" Then
						rs.Open "SELECT posts.postid, posts.image, posts.description, posts.owner, posts.category, posts.date_created, posts.upvote, posts.downvote, posts.genre, profiles.userid, profiles.complete_name, profiles.photo FROM profiles INNER JOIN posts ON profiles.userid = posts.`owner` " & whereClause & " ORDER BY date_created DESC", cn
					Else
						rs.Open "SELECT posts.postid, posts.image, posts.description, posts.owner, posts.category, posts.date_created, posts.upvote, posts.upvote, downvote, posts.genre, profiles.userid, profiles.complete_name, profiles.photo FROM profiles INNER JOIN posts ON profiles.userid = posts.`owner` WHERE description LIKE '%" & Request.QueryString("txtSearch") & "%' " & whereClause & " ORDER BY description ASC", cn
					End If

						do until rs.eof
						Dim photo_base64, avatar, user, pid
						photo_base64 = rs("image")
						avatar = rs("photo")
						user = Session("uid")
						pid = rs("postid")

						
							response.write "<div class='post-container'>"
							response.write "<div class='user-profile'>"
								if avatar = "" then
									response.write "<p style='text-align:center;'><a href='visit.asp?id=" & rs.fields("userid") & "'><img src='./assets/images/default.png' class='img-circle' width='40px' height='38px' title='Visit Profile'></a></p>"
								else
									response.write "<p style='text-align:center;'><a href='visit.asp?id=" & rs.fields("userid") & "'><img src='" & avatar & "' class='img-circle' width='40px' height='38px' title='Visit Profile'></a></p>"
								end if
							response.write "<div>"
							response.write "<p class='main-name'><a href='visit.asp?id=" & rs.fields("userid") & "'>" & rs.fields("complete_name") & "</a></p>"
							
							response.write "<span>" & rs.fields("date_created") & "</span><br>"
							response.write "<span><b>" & rs.fields("category") & " | " & rs.fields("genre") & "</b></span>"
							
							response.write "</div>"
							response.write "</div>"

							if rs.fields("owner") <> user Then
							' Check if the user has reported the post
							Dim hasReported
							hasReported = HasReportedPost(rs("postid"))
							
							if hasReported Then
							  response.write "<div class='report-icon'>"
							  response.write "<a class='report-button'><i>Post Reported</i></a>"
							  response.write "</div>"
							else
							  response.write "<div class='report-icon'>"
							  response.write "<a class='report-button' data-bs-toggle='modal' data-bs-target='#reportModal' data-postid='"& pid &"'><img src='./assets/images/report.png' alt='' title='Report Post' ></a>"
							  response.write "</div>"
							end if
						  end if
							
							response.write "<p class='post-text'>" & rs.fields("description") & "</p>"
							response.write "<img src='" & photo_base64 & "' alt='' class='post-img' />"
							response.write "<div class='post-row'>" 
							response.write "<div class='activity-icons'>"
								response.write "<button id='likeButton_" & rs("postid") & "' onclick='like(" & pid & ")'><img src='./assets/images/like.png' alt='' width='30' height='30'></button>"
								response.write "<span id='likeCount_" & rs("postid") & "'>"& rs.fields("upvote") &"</span>"
								response.write "<button id='dislikeButton_" & rs("postid") & "' onclick='dislike(" & pid & ")'><img src='./assets/images/dislike.png' alt='' width='30' height='30'></button>"
								response.write "<span id='dislikeCount_" & rs("postid") & "'>"& rs.fields("downvote") &"</span>"
								
																

								dim cr
								Set cr = Server.CreateObject("ADODB.Recordset")
								cr.Open "SELECT COUNT(*) AS total_comments FROM comments WHERE postid=" & pid, cn

								Dim total_comments
								total_comments = cr("total_comments")
								cr.Close
								Set cr = Nothing

							if rs.fields("owner") = user Then
								response.write "<div style='margin-left: 20px;'><a href='ownercomment.asp?id=" & rs.fields("postid") & "'><img src='./assets/images/comment.png' width='30' height='30' title='View comments'></a>"& total_comments &"</div>"
							else 
								response.write "<div style='margin-left: 20px;'><a href='comment.asp?id=" & rs.fields("postid") & "'><img src='./assets/images/comment.png' width='30' height='30' title='Add comment'></a>"& total_comments &"</div>"
							end if
							
								response.write "</div>"
								
							response.write "</div>"
							response.write "</div>"
							rs.movenext
						loop
						rs.close
					%>
				</div>
				
		<div class="right-sidebar">
			<div class="sidebar-title">
				<% 
				if profilepic = "" then
					response.write"<a href='profile.asp'><img src='./assets/images/default.png' width='120' height='120' padding='2%'>"
				else
					response.write"<a href='profile.asp'><img src='" & profilepic & "' width='120' height='120' padding='2%'>" 
				end if

				%>
				
				<p class="name" style="text-decoration: none;"><%= username %></p></a>
				<a href="mycontents.asp">
					<button class="contents">My Contents</button>
				</a>
			</div>
		</div>	
	</div>
	
	
	<div class="modal" id="reportModal">
		<div class="modal-dialog" role="document">
		  <div class="modal-content">
			<div class="modal-header">
			  <h3 class="modal-title"><b>Report Post</b></h3>
			  <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close">
				<span aria-hidden="true"></span>
			  </button>
			</div>
			<div class="modal-body">
			  <p>Select Violation</p>
			  <form id="reportForm" method="post" action="submitreports.asp">
				<input type="hidden" name="postid" id="postid" value="">
				<fieldset class="form-group">
				  <div class="form-check">
					<input class="form-check-input" type="checkbox" name="violation" value="Inappropriate or Abusive" id="abusive">
					<label class="form-check-label" for="abusive">
					  Inappropriate/Abusive
					</label>
				  </div>
				  <div class="form-check">
					<input class="form-check-input" type="checkbox" name="violation" value="Offensive" id="offensive">
					<label class="form-check-label" for="offensive">
					  Offensive
					</label>
				  </div>
				  <div class="form-check">
					<input class="form-check-input" type="checkbox" name="violation" value="False Information" id="false">
					<label class="form-check-label" for="false">
					  False Information
					</label>
				  </div>
				  <div class="form-group">
					<label for="exampleTextarea" class="form-label mt-4">Others:</label>
					<textarea class="form-control" id="exampleTextarea" rows="3" name="others" spellcheck="false"></textarea>
				  </div>
				</fieldset>
			  </form>
			</div>
			<div class="modal-footer">
			  <button id="reportButton" type="button" class="btn btn-primary">Report</button>
			  <button type="button" class="btn btn-secondary" data-bs-dismiss="modal">Close</button>
			</div>
		  </div>
		</div>
	  </div>
	  
	
	<script src="./assets/js/image.js"></script>
	<script src="./assets/js/report.js"></script>
	<script>

		// script for filter genre
		const genreDropdown = document.getElementById('genre');
	let selectedGenre = getSelectedGenre();

	// Set the initial selected genre
	genreDropdown.value = selectedGenre;

	// Listen for the change event on the genre dropdown
	genreDropdown.addEventListener('change', function() {
		const newSelectedGenre = this.value;
		if (newSelectedGenre !== selectedGenre) {
		updateSelectedGenre(newSelectedGenre);
		submitFilterForm();
		}
	});

	// Function to get the currently selected genre from the URL query parameter
	function getSelectedGenre() {
		const urlParams = new URLSearchParams(window.location.search);
		return urlParams.get('filter') || '';
	}

	// Function to update the selected genre in the URL query parameter
	function updateSelectedGenre(genre) {
		const urlParams = new URLSearchParams(window.location.search);
		urlParams.set('filter', genre);
		const newUrl = `${window.location.pathname}?${urlParams.toString()}`;
		window.history.replaceState({}, '', newUrl);
		selectedGenre = genre;
	}

	// Function to submit the filter form
	function submitFilterForm() {
		const form = document.querySelector('form');
		form.submit();
		location.reload(); // Refresh the page
	}
	//   end for filter genre

	// script for image upload
	
	//   end of image upload

	</script>
	</body>
	</html>
		
	<!--#include file="./templates/footer.asp"-->