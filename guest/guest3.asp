<!--#include file="dbconnection.asp"-->

<!DOCTYPE html>
<html>
<head>
	<meta charset="utf-8">
	<meta name="viewport" content="width=device-width, initial-scale=1">
	<link rel="stylesheet" type="text/css" href="../assets/css/home.css">
	<title>AuthoRevw</title>
	<style>
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
	</style>
</head>
<body style="background-color: #E6DCDC">

<!--#include file="guestheader.asp"-->
<a href="#" class="back-to-top">
	<img src="../assets/images/top.png" alt="Back to Top" />
  </a>

<div class="container">
	<div class="container">
	<div class="left-sidebar">
		<form method="get" action="guest.asp" class="d-flex">
			<input class="form-control me-sm-2" type="search" name="txtSearch" placeholder="Search">
		  </form>
	  <div class="imp-links">
		<a href="guest.asp">
			<button class="left-btn">All</button><br>
		</a>
		<a href="guest2.asp">
			<button class="left-btn">Books and Movies</button><br>
		</a>
		<a href="guest3.asp">
			<button class="left-btn" style="background-color: #bbb5b5;">Short Stories</button>
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

				<%
				set rs = server.createobject("adodb.recordset")
				Dim filterBy
				filterBy = request.querystring("filter")

				Dim whereClause
				if filterBy = "Action" then
					whereClause = "WHERE genre = 'Action' AND category = 'Short Story' AND tag = 1"
				elseif filterBy = "Comedy" then
					whereClause = "WHERE genre = 'Comedy' AND category = 'Short Story' AND tag = 1"
				elseif filterBy = "Drama" then
					whereClause = "WHERE genre = 'Drama' AND category = 'Short Story' AND tag = 1"
				elseif filterBy = "Romance" then
					whereClause = "WHERE genre = 'Romance' AND category = 'Short Story' AND tag = 1"
				elseif filterBy = "Horror" then
					whereClause = "WHERE genre = 'Horror' AND category = 'Short Story' AND tag = 1"
				elseif filterBy = "Fantasy" then
					whereClause = "WHERE genre = 'Fantasy' AND category = 'Short Story' AND tag = 1"
				elseif filterBy = "Thrill" then
					whereClause = "WHERE genre = 'Thrill' AND category = 'Short Story' AND tag = 1"
				else
					whereClause = "WHERE category = 'Short Story' AND tag = 1"
				end if

				If Request.QueryString("txtSearch") = "" Then
					rs.Open "SELECT posts.postid, posts.image, posts.description, posts.category, posts.date_created, posts.genre, profiles.complete_name, profiles.photo,  posts.upvote, posts.downvote FROM profiles INNER JOIN posts ON profiles.userid = posts.`owner` " & whereClause & " ORDER BY date_created DESC", cn
				Else
					rs.Open "SELECT posts.postid, posts.image, posts.description, posts.category, posts.date_created, posts.genre, profiles.complete_name, profiles.photo,  posts.upvote, posts.downvote FROM profiles INNER JOIN posts ON profiles.userid = posts.`owner` WHERE description LIKE '%" & Request.QueryString("txtSearch") & "%' " & whereClause & " ORDER BY description ASC", cn
				End If
				
					do until rs.eof
					Dim photo_base64, avatar, pid
					photo_base64 = rs("image")
					avatar = rs("photo")
					pid = rs("postid")
					
						response.write "<div class='post-container'>"
						response.write "<div class='user-profile'>"
						response.write "<p style='text-align:center;'><a href='../index.html'><img src='" & avatar & "' class='img-circle' width='40px' height='38px'></a></p>"
						response.write "<div>"
						response.write "<p class='main-name'><a href='../index.html'>" & rs.fields("complete_name") & "</a></p>"
						response.write "<span>" & rs.fields("date_created") & "</span><br>"
						response.write "<span><b>" & rs.fields("category") & " | " & rs.fields("genre") & "</b></span>"
						response.write "</div>"
						response.write "</div>"
						
						response.write "<p class='post-text'>" & rs.fields("description") & "</p>"
						response.write "<img src='" & photo_base64 & "' class='post-img'>"
						response.write "<div class='post-row'>" 
						response.write "<div class='activity-icons'>"
							response.write "<div><a href='../index.html'><img src='../assets/images/like.png' width='30' height='30'></a> "& rs.fields("upvote")&"</div>"
							response.write "<div><a href='../index.html'><img src='../assets/images/dislike.png' width='30' height='30'></a> "& rs.fields("downvote")&" </div>"

							dim cr
								Set cr = Server.CreateObject("ADODB.Recordset")
								cr.Open "SELECT COUNT(*) AS total_comments FROM comments WHERE postid=" & pid, cn

								Dim total_comments
								total_comments = cr("total_comments")
								cr.Close
								Set cr = Nothing

						response.write "<div><a href='../index.html'><img src='../assets/images/comment.png' width='30' height='30'></a>"& total_comments &"</div>"
						response.write "</div>"
						response.write "</div>"
						response.write "</div>"
						
						
						rs.movenext
					loop


					rs.close
				%>
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
</script>
<!--#include file="footer.asp"-->
