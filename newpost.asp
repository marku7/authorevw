<!--#include file="./templates/dbConnection.asp"-->
<!DOCTYPE html>
<html lang="en" dir="ltr">
  <head>
    <meta charset="utf-8">
    <title>Authorevw</title>
    <link rel="stylesheet" href="./assets/css/post.css">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/5.15.3/css/all.min.css"/>
    <style>
      .img-circle {
        border-radius: 50%;
      }
    </style>
  </head>
  <body>

    <%
			set rs=server.createobject("adodb.recordset")
			rs.open "SELECT * FROM profiles WHERE userid = '"& Session("uid") &"'", cn
			Dim profilepic, username
			profilepic = rs("photo")
			username = rs.fields("complete_name")

            %>
    <div class="container">
      <div class="wrapper">
        <section class="post">
          <header>
            Add a Review
            <a href="mycontents.asp" class="close-button">
              <i class="fas fa-times"></i>
            </a>
          </header>
          <form action="addpost.asp" method="post">
            <div class="content">
              <% response.write "<img src='" & profilepic & "' alt='' class='img-circle' width='50px' height='50px'>" %>
              <div class="details">
                <p><%= username %></p>
              </div>
            </div>
            <textarea placeholder="Enter description" name="description" spellcheck="false" required></textarea>
            <div class="options">
              <label for="genre">Genre:</label>
              <select id="genre" name="genre">
                <option value="Action">Action</option>
                <option value="Comedy">Comedy</option>
                <option value="Drama">Drama</option>
                <option value="Romance">Romance</option>
                <option value="Horror">Horror</option>
                <option value="Fantasy">Fantasy</option>
                <option value="Thrill">Thrill</option>
              </select>
              <label for="category">Category:</label>
              <select id="category" name="category">
                <option value="Movie">Movie</option>
                <option value="Book">Book</option>
                <option value="Short Story">Short Story</option>
              </select>
            </div>
            <div class="options">
              <p>Add image to your post</p>
              <input type="file" name="photo" id="photo" onchange="uploadAndProcessImage(event)"/>
              <input type="hidden" id="base64" name="base64">
            </div>
            <div class="image-container">
              <img id="preview" src="#" alt="Image Preview" style="width: 200px; height: 200px; display: none;">
            </div>
            <button>Post</button>
          </form>
        </section>
      </div>
    </div>

    <script>
      //image script
      const uploadAndProcessImage = async (event) => {
        const file = event.target.files[0];
        const img = new Image();
        img.src = URL.createObjectURL(file);
        img.onload = function() {
          cropAndCompressImage(this);
          document.querySelector("#preview").style.display = "block";
          document.querySelector("#preview").src = URL.createObjectURL(file);
          document.querySelector(".options p").textContent = ""; // Clear the text
        };
        console.log(file);
      };

      function cropAndCompressImage(img) {
        const aspectRatio = img.width / img.height;
        let cropWidth, cropHeight, cropX, cropY;

        if (aspectRatio > 1) {
          cropWidth = img.height;
          cropHeight = img.height;
          cropX = (img.width - cropWidth) / 2;
          cropY = 0;
        } else {
          cropWidth = img.width;
          cropHeight = img.width;
          cropX = 0;
          cropY = (img.height - cropHeight) / 2;
        }

        const canvas = document.createElement('canvas');
        canvas.width = 800;
        canvas.height = 800;

        const ctx = canvas.getContext('2d');
        ctx.drawImage(img, cropX, cropY, cropWidth, cropHeight, 0, 0, canvas.width, canvas.height);

        const jpegURL = canvas.toDataURL('image/jpeg', 0.8);
        document.querySelector("#base64").value = jpegURL;
        console.log(jpegURL); // Added console log to see the base64 string
      }
    </script>
  </body>
</html>
