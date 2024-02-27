document.getElementById('custom-button').addEventListener('click', function() {
    document.getElementById('photo').click();
});

document.getElementById('photo').addEventListener('change', function(event) {
    uploadAndProcessImage(event);
});

function uploadAndProcessImage(event) {
    const file = event.target.files[0];
    const img = new Image();
    img.src = URL.createObjectURL(file);
    img.onload = function() {
    cropAndCompressImage(this);
    document.querySelector("#preview").style.display = "block";
    document.querySelector("#preview").src = URL.createObjectURL(file);
    };
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