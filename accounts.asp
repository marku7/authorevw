<!--#include file="./templates/dbConnection.asp"-->

<!DOCTYPE html>
<html>
<head>
	<meta charset="utf-8">
	<meta name="viewport" content="width=device-width, initial-scale=1">
	<link rel="stylesheet" type="text/css" href="../assets/css/home.css">
	<title>AuthoRevw - Administrator</title>

</head>
<body style="background-color: #E6DCDC">

<!--#include file="./templates/adminheader.asp"-->
<div class="collapse navbar-collapse" id="navbarColor01">
	<ul class="navbar-nav me-auto">
	  <li class="nav-item">
		<a class="nav-link" href="admin.asp">Manage Posts
		  
		</a>
	  </li>
	  <li class="nav-item">
		<a class="nav-link" href="reports.asp">Manage Reports</a>
	  </li>
	  <li class="nav-item">
		  <a class="nav-link active" href="accounts.asp">Manage Accounts</a>
		  <span class="visually-hidden">(current)</span>
		</li>
	  <li class="nav-item">
		  <a class="nav-link" href="logout.asp">Logout</a>
		</li>
	</ul>
	
  </div>
</div>
</nav>
<div class="container">

<h1 class="text-center"><br>Manage Accounts</h1><br>
<form  method="get" action="accounts.asp">
    Search: <input type="text" name="txtSearch" placeholder="Name">
</form><br>
<div class="form-group">
	<label for="status">Filter by: &nbsp;</label>
	<select name="status" id="status">
	  <option value="">All</option>
	  <option value="Active">Active</option>
	  <option value="Disabled">Disabled</option>
	</select>
  </div>
<br>

<div class="form-group">
	<label for="sort">Order by: &nbsp;</label>
	<select name="sort" id="sort">
	  <option value="">Newest</option>
	  <option value="Oldest">Oldest</option>
	  <option value="Most">Most reports received</option>
	  <option value="Least">Least repoets received</option>
	  <option value="Active">Active</option>
	  <option value="Disabled">Disabled Account</option>
	</select>
  </div>
<br>

<%
	set rs = server.createobject("adodb.recordset")

	Dim filterBy
	filterBy = request.querystring("filterby")

	Dim whereclause
	if filterBy = "Active" then
		whereclause = "WHERE status = '1'"      
	elseif filterBy = "Disabled" then
		whereclause = "WHERE status = '0'"
  	else
	  whereClause = ""
	end if

	Dim sortBy
	sortBy = request.querystring("sortby")
	Dim sortclause

	if sortBy = "Oldest" then
		sortclause = "ORDER BY created_at ASC"        
	elseif sortBy = "Most" then
		sortclause = "ORDER BY reportcount DESC"
	elseif sortBy = "Least" then
		sortclause = "ORDER BY reportcount ASC"
	else
		sortclause = "ORDER BY created_at DESC"
	end if

	if request.querystring("txtSearch") = "" then
		rs.open "SELECT * FROM profiles "& whereClause & sortclause, cn
	else
		rs.open "SELECT * FROM profiles WHERE complete_name like '%" & request.querystring("txtSearch") & "%' "& whereClause & sortclause, cn
	end if
	response.write "<table class='table table-hover'>"
	response.write "<thead>"
	response.write "<tr class='table-info'>"
		response.write "<th class='text-center'>&nbsp;</th>"
	response.write "<th>User Info</th>"
	response.write "<th class='text-center'>Email and Password</th>"
	response.write "<th class='text-center'>Date Registered</th>"
	response.write "<th class='text-center'>Reports Received</th>"
	response.write "<th class='text-center'>Status</th>"
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
	photo_base64 = rs("photo")

	response.write " <tr class='table-secondary'>"
	if photo_base64 = "null" then
		response.write "<td><img src='./assets/images/default.png' alt='' style='border-radius: 50%;' height='80px'>&nbsp; "& rs.fields("complete_name") &"<br>"& rs.fields("gender") &"</td>"
	else
		response.write "<td class='text-center'><img src='" & photo_base64 & "' alt='' height='80px' style='border-radius: 50%;'></td>"
	end if

	response.write "<td>" & rs.fields("complete_name")&"<br><i>"& rs.fields("gender") &"</i></td>"
	response.write "<td class='text-center'>" & rs.fields("email_address") & " <br> " & rs.fields("pword") &"</td>"
	response.write "<td class='text-center'>"& rs.fields("created_at") &"</td>"
	response.write "<td class='text-center'>"& rs.fields("reportcount") &"</td>"

	if rs.fields("status") = 0 then
    response.write "<td class='text-center'><a href='adminenable.asp?id=" & rs.fields("userid") & "'><img src='./assets/images/off.png' alt='' title='Enable Account'></a> Disabled </td>"
	else
		response.write "<td class='text-center'><a href='admindisable.asp?id=" & rs.fields("userid") & "'><img src='./assets/images/on.png' alt='' title='Disable Account'></a> Active </td>"
	end if

	
	response.write "<td class='text-center'><a href='adminremove.asp?id=" & rs.fields("userid") & "'><img src='./assets/images/rem.png' alt='' title='Remove Account'></a></td>"
	response.write "</tr>"
	response.write "</tbody>"

	rs.movenext
	loop
end if
rs.close
response.write "</table>"
%>

<script>
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

	// script for filter genre
	const statusDropdown = document.getElementById('status');
		let selectedStatus = getSelectedStatus();

		// Set the initial selected genre
		statusDropdown.value = selectedStatus;

		// Listen for the change event on the genre dropdown
		statusDropdown.addEventListener('change', function() {
			const newSelectedStatus = this.value;
			if (newSelectedStatus !== selectedStatus) {
			updateSelectedStatus(newSelectedStatus);
			submitStatusForm();
			}
		});

		// Function to get the currently selected genre from the URL query parameter
		function getSelectedStatus() {
			const urlParams = new URLSearchParams(window.location.search);
			return urlParams.get('filterby') || '';
		}

		// Function to update the selected genre in the URL query parameter
		function updateSelectedStatus(status) {
			const urlParams = new URLSearchParams(window.location.search);
			urlParams.set('filterby', status);
			const newUrl = `${window.location.pathname}?${urlParams.toString()}`;
			window.history.replaceState({}, '', newUrl);
			selectedStatus = status;
		}

		// Function to submit the filter form
		function submitStatusForm() {
			const form = document.querySelector('form');
			form.submit();
			location.reload(); // Refresh the page
		}
		//   end for filter genre

	
</script>

<!--#include file="./templates/footer.asp"-->
