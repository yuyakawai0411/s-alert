window.addEventListener('load', function(){
if ( document.getElementById('user-menu')){
  const pullDownButton = document.getElementById("user-menu")
  const pullDownParents = document.getElementById("pull-down")
  // LOGINをクリックした時に新規登録かログインかを表示する
  pullDownButton.addEventListener('click', function(){
    if (pullDownParents.getAttribute("style") == "display:block;") {
      pullDownParents.removeAttribute("style", "display:block;")
    } else {
      pullDownParents.setAttribute("style", "display:block;")
    }
  });
}
})