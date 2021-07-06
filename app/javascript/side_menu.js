window.addEventListener('load', function(){
  if ( document.getElementById('side_menu')){
    const SideMenu = document.getElementById("side_menu")
    const SideMenuBar = document.getElementById("side_menu_bar")

    console.log("ok")
  
    SideMenu.addEventListener('click', function(){
      if (SideMenuBar.getAttribute("style") == "display:block;") {
        SideMenuBar.removeAttribute("style", "display:block;")
      } else {
        SideMenuBar.setAttribute("style", "display:block;")
      }
    });
  
  }
  })