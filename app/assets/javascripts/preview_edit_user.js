function PreviewImage(image_id) {
  var oFReader = new FileReader();
  oFReader.readAsDataURL(document.getElementById("user_picture").files[0]);

  oFReader.onload = function(oFREvent) {
    document.getElementById(image_id).src = oFREvent.target.result;
  };
};
