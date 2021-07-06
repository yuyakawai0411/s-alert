window.addEventListener('load', function(){
  if ( document.getElementById('card-edit')){
    const pullDownButtonCard = document.getElementById("card-edit-menu")
    const pullDownParentsCard = document.getElementById("card-pull-down")
    const pullDownButtonRecord = document.getElementById("record-edit-menu")
    const pullDownParentsRecord = document.getElementById("record-pull-down")
  
    pullDownButtonCard.addEventListener('click', function(){
      if (pullDownParentsCard.getAttribute("style") == "display:block;") {
        pullDownParentsCard.removeAttribute("style", "display:block;")
      } else {
        pullDownParentsCard.setAttribute("style", "display:block;")
      }
    });
  
    pullDownButtonRecord.addEventListener('click', function(){
      if (pullDownParentsRecord.getAttribute("style") == "display:block;") {
        pullDownParentsRecord.removeAttribute("style", "display:block;")
      } else {
        pullDownParentsRecord.setAttribute("style", "display:block;")
      }
    });




  }
  })

