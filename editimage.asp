<!--#include file="./templates/header.asp"-->

<style>
  .form-wrapper {
    display: flex;
    justify-content: center;
    height: 100vh;
  }

  .image-container {
    display: flex;
    justify-content: center;
    align-items: center;
    margin-bottom: 20px;
  }

  .form-group {
    margin-bottom: 20px;
    text-align: center;
  }

  .cancel-button {
    margin-left: 10px;
  }
</style>


  <%
  dim uid
  uid = request.querystring("id")
  %>
  
  <div class="form-wrapper">
    <div class="signup-box">
      <h1>Edit Image Photo</h1>
      <form method="post" action="changeimage.asp?id=<%= uid %>">
        <div class="image-container">
          <img id="preview" src="#" alt="Image Preview" class="avatar-circle" style="width: 300px; height: 300px; display: none;">
        </div>
        <div class="form-group">
          <label for="formFile" class="form-label mt-4">Upload Image</label>
          <input class="form-control" type="file" name="photo" id="photo" onchange="uploadAndProcessImage(event)">
          <input type="hidden" id="base64" name="base64">
        </div>
  
        <div class="form-group">
          <input type="submit" name="submit" class="btn btn-outline-primary" value="Save" />
          <button type="button" class="btn btn-outline-primary cancel-button"><a href="mycontents.asp">Cancel</a></button>
        </div>
      </form>
    </div>
  </div>
  
    

    <script>
      const uploadAndProcessImage = async (event) => {
    const file = event.target.files[0];
    const img = new Image();
    img.src = URL.createObjectURL(file);
    img.onload = function() {
      cropAndCompressImage(this);
      document.querySelector("#preview").style.display = "block";
      document.querySelector("#preview").src = URL.createObjectURL(file);
    }
    console.log(file);
  }
  
    
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