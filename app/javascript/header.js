window.addEventListener('load', function(){
if ( document.getElementById('user-menu')){
  const pullDownButton = document.getElementById("user-menu")
  const pullDownParents = document.getElementById("pull-down")

  // pullDownButton.addEventListener('mouseover', function(){
  //   this.setAttribute("style", "background-color:#FFBEDA;")
  // });

  // pullDownButton.addEventListener('mouseout', function(){
  //   this.removeAttribute("style", "background-color:#FFBEDA;")
  // });

  pullDownButton.addEventListener('click', function(){
    if (pullDownParents.getAttribute("style") == "display:block;") {
      pullDownParents.removeAttribute("style", "display:block;")
    } else {
      pullDownParents.setAttribute("style", "display:block;")
    }
  });
}
})