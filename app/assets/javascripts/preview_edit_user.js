var oFReader = new FileReader();
oFReader.readAsDataURL(document.getElementById("user_picture").files[0]);

oFReader.onload = function(oFREvent) {
  document.getElementById("user_image").src = oFREvent.target.result;
};

function PreviewImage() {
  var oFReader = new FileReader();
  oFReader.readAsDataURL(document.getElementById("user_picture").files[0]);

  oFReader.onload = function(oFREvent) {
    document.getElementById("user_image").src = oFREvent.target.result;
  };
};
