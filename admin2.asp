<!--#include file="./templates/dbConnection.asp"-->

<!DOCTYPE html>
<html>
<head>
	<meta charset="utf-8">
	<meta name="viewport" content="width=device-width, initial-scale=1">
	<link rel="stylesheet" type="text/css" href="../assets/css/home.css">
	<title>AuthoRevw - Administrator</title>
	<style>
		.imp-links {
		display: flex;
		justify-content: right;
		margin-bottom: -70px;
	}

	.left-btn {
		margin: 10px 0;
		padding: 10px;
		border-radius: 8px;
		box-shadow: 0 2px 4px rgba(0, 0, 0, 0.2);
		background-color: #ccc6c6;
		border: none;
		color: black;
		font-size: 12px;
		cursor: pointer;
		transition: background-color 0.3s ease;
	}
	</style>

</head>
<body style="background-color: #E6DCDC">

<!--#include file="./templates/adminheader.asp"-->

<div class="collapse navbar-collapse" id="navbarColor01">
	<ul class="navbar-nav me-auto">
	  <li class="nav-item">
		<a class="nav-link active" href="admin.asp">Manage Posts
		  <span class="visually-hidden">(current)</span>
		</a>
	  </li>
	  <li class="nav-item">
		<a class="nav-link" href="reports.asp">Manage Reports</a>
	  </li>
	  <li class="nav-item">
		  <a class="nav-link" href="accounts.asp">Manage Accounts</a>
		</li>
	  <li class="nav-item">
		  <a class="nav-link" href="logout.asp">Logout</a>
		</li>
	</ul>
	
  </div>
</div>
</nav>
<div class="container">
	
	<h1 class="text-center"><br>Manage Posts</h1><br>

	<div class="imp-links">
		<a href="admin.asp">
			<button class="left-btn" >All</button><br>
		</a>&nbsp; &nbsp;
		<a href="admin2.asp">
			<button class="left-btn" style="background-color: #bbb5b5;">Books and Movies</button>
		</a>&nbsp; &nbsp;
		<a href="admin3.asp">
			<button class="left-btn">Short Stories</button>
		</a>
	</div>
	<form  method="get" action="admin.asp">
		Search: <input type="text" name="txtSearch" placeholder="Post / Owner Description" style="min-width: 300px;">
	</form><br>

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
  </div><br>

<div class="form-group">
	<label for="sort">Order by: &nbsp;</label>
	<select name="sort" id="sort">
	  <option value="">Newest</option>
	  <option value="Oldest">Oldest</option>
	</select>
  </div>
<br>

<%
	set rs = server.createobject("adodb.recordset")

	Dim filterBy
	filterBy = request.querystring("filter")
	Dim whereClause

	if filterBy = "Action" then
		whereClause = "WHERE genre = 'Action' AND (category = 'Book' OR category = 'Movie')"
	elseif filterBy = "Comedy" then
		whereClause = "WHERE genre = 'Comedy' AND (category = 'Book' OR category = 'Movie')"
	elseif filterBy = "Drama" then
		whereClause = "WHERE genre = 'Drama' AND (category = 'Book' OR category = 'Movie')"
	elseif filterBy = "Romance" then
		whereClause = "WHERE genre = 'Romance' AND (category = 'Book' OR category = 'Movie')"
	elseif filterBy = "Horror" then
		whereClause = "WHERE genre = 'Horror' AND (category = 'Book' OR category = 'Movie')"
	elseif filterBy = "Fantasy" then
		whereClause = "WHERE genre = 'Fantasy' AND (category = 'Book' OR category = 'Movie')"
	elseif filterBy = "Thrill" then
		whereClause = "WHERE genre = 'Thrill' AND (category = 'Book' OR category = 'Movie')"
	else
		whereClause = "WHERE category = 'Book' OR category = 'Movie'"
	end if

	Dim sortBy
	sortBy = request.querystring("sortby")
	Dim sortclause

	if sortBy = "Oldest" then
		sortclause = "ORDER BY date_created ASC"        
	else
		sortclause = "ORDER BY date_created DESC"
	end if

	if request.querystring("txtSearch") = "" then
		rs.open "SELECT profiles.complete_name, posts.postid, posts.description, posts.category, posts.genre, posts.image, posts.date_created FROM posts INNER JOIN profiles ON posts.owner = profiles.userid "& whereClause & sortclause, cn
	else
		rs.open "SELECT profiles.complete_name, posts.postid, posts.description, posts.category, posts.genre, posts.image, posts.date_created FROM posts INNER JOIN profiles ON posts.owner = profiles.userid WHERE complete_name LIKE '%" & request.querystring("txtSearch") & "%' OR description LIKE '%" & request.querystring("txtSearch") & "%' " & whereClause & sortclause, cn
	end if
	response.write "<table class='table table-hover'>"
	response.write "<thead>"
	response.write "<tr class='table-info'>"
	response.write "<th class='text-center'>Image</th>"
	response.write "<th class='text-center'>Owner</th>"
	response.write "<th class='text-center'>Description</th>"
	response.write "<th class='text-center'>Category and Genre</th>"
	response.write "<th class='text-center'>Date Posted</th>"
	response.write "<th class='text-center'>Action</th>"
	response.write " </tr>"
	response.write "</thead>"
	response.write "<tbody>"

if rs.eof then
	response.write "<tr>"
	response.write "<td colspan='9' align='center'>No records found.</td>"
	response.write "</tr>"
else
	do until rs.eof

	Dim photo_base64
	photo_base64 = rs("image")

	response.write " <tr class='table-secondary'>"
	if photo_base64 = "" then
		response.write "<td class='text-center'><img src='./assets/images/book.png' alt='' height='100px'></td>"
	else
		response.write "<td class='text-center'><img src='" & photo_base64 & "' alt='' height='100px'></td>"
	end if
	response.write "<td class='text-center'>"& rs.fields("complete_name") &"</td>"
	response.write "<td class='text-center'>"

	response.write "<div class='accordion' id='accordionExample" & rs.fields("postid") & "'>"
	response.write "<div class='accordion-item'>"
	response.write "<h2 class='accordion-header' id='headingOne'>"
	response.write "<button class='accordion-button collapsed' type='button' data-bs-toggle='collapse' data-bs-target='#collapseOne" & rs.fields("postid") & "' aria-expanded='false' aria-controls='collapseOne" & rs.fields("postid") & "'>Show Description</button>"
	response.write "</h2>"
	response.write "<div id='collapseOne" & rs.fields("postid") & "' class='accordion-collapse collapse' aria-labelledby='headingOne' data-bs-parent='#accordionExample" & rs.fields("postid") & "'>"
	response.write "<div class='accordion-body'>"& rs.fields("description") &"</div>"
	response.write "</div>"
	response.write "</div>"
	response.write "</div>"
	response.write "</td>"
	response.write "<td class='text-center'>" & rs.fields("category") & " | " & rs.fields("genre") &"</td>"
	response.write "<td class='text-center'>"& rs.fields("date_created") &"</td>"
	response.write "<td class='text-center'><a href='admindelete.asp?id=" & rs.fields("postid") & "'><img src='./assets/images/rem.png' alt='' title='Remove Post'></a></td>"
	response.write "</tr>"
	response.write "</tbody>"

	rs.movenext
	loop
	end if
	rs.close
	response.write "</table>"
	%>
</div>
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

	// script for filter genre
	const sortDropdown = document.getElementById('sort');
	let selectedSort = getSelectedSort();

	// Set the initial selected genre
	sortDropdown.value = selectedSort;

	// Listen for the change event on the genre dropdown
	sortDropdown.addEventListener('change', function() {
		const newSelectedSort = this.value;
		if (newSelectedSort !== selectedSort) {
		updateSelectedSort(newSelectedSort);
		submitSortForm();
		}
	});

	// Function to get the currently selected genre from the URL query parameter
	function getSelectedSort() {
		const urlParams = new URLSearchParams(window.location.search);
		return urlParams.get('sortby') || '';
	}

	// Function to update the selected genre in the URL query parameter
	function updateSelectedSort(sort) {
		const urlParams = new URLSearchParams(window.location.search);
		urlParams.set('sortby', sort);
		const newUrl = `${window.location.pathname}?${urlParams.toString()}`;
		window.history.replaceState({}, '', newUrl);
		selectedSort = sort;
	}

	// Function to submit the filter form
	function submitSortForm() {
		const form = document.querySelector('form');
		form.submit();
		location.reload(); // Refresh the page
	}
</script>

<!--#include file="./templates/footer.asp"-->
