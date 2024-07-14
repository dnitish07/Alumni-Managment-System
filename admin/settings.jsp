<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="ISO-8859-1">
<link href='https://unpkg.com/boxicons@2.0.9/css/boxicons.min.css' rel='stylesheet'>
<link rel="stylesheet" href="style.css">
<link rel="stylesheet" href="styles.css">
<style>
	img#cimg {
		max-height: 10vh;
		max-width: 6vw;
	}
</style>
<title>Settings</title>
</head>
<body>
<section id="sidebar">
		<a href="index.jsp" class="brand">
			<img src="logo.png" style="height: 80px; width: 100px; margin: 10px; margin-top:50px;">
			<span class="text" style="padding: 5px; margin-top:40px; font-size: 40px;">Admin</span>
		</a>
		<ul class="side-menu top">
			<li class="active">
				<a href="index.jsp">
					<i class='bx bxs-dashboard' ></i>
					<span class="text">Home</span>
				</a>
			</li>
			<li>
				<a href="gallery.jsp">
					<i class='bx bxs-shopping-bag-alt' ></i>
					<span class="text">Gallery</span>
				</a>
			</li>
			<li>
				<a href="course.jsp">
					<i class='bx bxs-doughnut-chart' ></i>
					<span class="text">Course List</span>
				</a>
			</li>
			<li>
				<a href="alumni_list.jsp">
					<i class='bx bxs-message-dots' ></i>
					<span class="text">Alumni list</span>
				</a>
			</li>
			<li>
				<a href="jobs.jsp">
					<i class='bx bxs-group' ></i>
					<span class="text">Jobs</span>
				</a>
			</li>
            <li>
				<a href="forms.jsp">
					<i class='bx bxs-group' ></i>
					<span class="text">Forms</span>
				</a>
			</li>
                <li>
                    <a href="events.jsp">
                        <i class='bx bxs-group' ></i>
                        <span class="text">Events</span>
                    </a>
                </li>
		</ul>
		<ul class="side-menu">
			<li>
				<a href="settings.jsp">
					<i class='bx bxs-cog' ></i>
					<span class="text">Settings</span>
				</a>
			</li>
			<li>
				<a href="admin.html" class="logout">
					<i class='bx bxs-log-out-circle' ></i>
					<span class="text">Logout</span>
				</a>
			</li>
		</ul>
	</section>
	<section id="content">
		<nav>
			<i class='bx bx-menu' ></i>
			<a href="adminhome.jsp" class="nav-link">Welcome Admin</a>
			<form action="#">
				<div class="form-input">
					<input type="search" placeholder="Search...">
					<button type="submit" class="search-btn"><i class='bx bx-search' ></i></button>
				</div>
			</form>
			<input type="checkbox" id="switch-mode" hidden>
			<label for="switch-mode" class="switch-mode"></label>
			<a href="#" class="profile">
				<img src="people.png">
			</a>
		</nav>
		
		<main>
		
		<div class="container-fluid">
	
	<div class="card col-lg-12">
		<div class="card-body">
			<form action="" id="manage-settings" method="post" enctype="multipart/form-data">
				<div class="form-group">
					<label for="name" class="control-label">System Name</label>
					<input type="text" class="form-control" id="name" name="name" value="<%= request.getAttribute("name") != null ? request.getAttribute("name") : "" %>" required>
				</div>
				<div class="form-group">
					<label for="email" class="control-label">Email</label>
					<input type="email" class="form-control" id="email" name="email" value="<%= request.getAttribute("email") != null ? request.getAttribute("email") : "" %>" required>
				</div>
				<div class="form-group">
					<label for="contact" class="control-label">Contact</label>
					<input type="text" class="form-control" id="contact" name="contact" value="<%= request.getAttribute("contact") != null ? request.getAttribute("contact") : "" %>" required>
				</div>
				<div class="form-group">
					<label for="about" class="control-label">About Content</label>
					<textarea name="about" class="text-jqte"><%= request.getAttribute("about_content") != null ? request.getAttribute("about_content") : "" %></textarea>
				</div>
				<div class="form-group">
					<label for="" class="control-label">Image</label>
					<input type="file" class="form-control" name="img" onchange="displayImg(this)">
				</div>
				<div class="form-group">
					<img src="<%= request.getAttribute("cover_img") != null ? "assets/uploads/" + request.getAttribute("cover_img") : "" %>" alt="" id="cimg">
				</div>
				<center>
					<button class="btn btn-info btn-primary btn-block col-md-2">Save</button>
				</center>
			</form>
		</div>
	</div>
	</div>
		
		</main>
	</section>
	<script src="script.js"></script>
	<script>
	function displayImg(input) {
		if (input.files && input.files[0]) {
			var reader = new FileReader();
			reader.onload = function (e) {
				document.getElementById('cimg').src = e.target.result;
			}
			reader.readAsDataURL(input.files[0]);
		}
	}
	
	$('.text-jqte').jqte();

	document.getElementById('manage-settings').onsubmit = function(e) {
		e.preventDefault();
		start_load();
		var formData = new FormData(this);
		
		fetch('ajax.jsp?action=save_settings', {
			method: 'POST',
			body: formData
		})
		.then(response => response.text())
		.then(resp => {
			if (resp.trim() == "1") {
				alert_toast('Data successfully saved.', 'success');
				setTimeout(function() {
					location.reload();
				}, 1000);
			}
		})
		.catch(err => console.log(err));
	}
	</script>
</body>
</html>
