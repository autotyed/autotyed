function toggleIndigo() {
  var indigoPages = document.getElementsByClassName("indigoPage");
  for(var i = 0; i < indigoPages.length; i++){
    if (indigoPages[i].style.display == "none") {
      indigoPages[i].style.display = "block";
    } else {
      indigoPages[i].style.display = "none";
    }
  }
}
