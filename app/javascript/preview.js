document.addEventListener('DOMContentLoaded', function(){
  if ( document.getElementById('card_image')){
    const ImageList = document.getElementById('image-list');
    // 画像をプレビューで表示
    const createImageHTML = (blob) => {
      const imageElement = document.createElement('div');
      const blobImage = document.createElement('img');
      blobImage.setAttribute('src', blob);
      blobImage.setAttribute('id', 'img');
      imageElement.appendChild(blobImage);
      ImageList.appendChild(imageElement);
    };
    //画像が表示されている場合のみ、すでに存在している画像を削除する
    document.getElementById('card_image').addEventListener('change', function(e){
    const imageContent = document.querySelector('img');
    if (imageContent){
        imageContent.remove();
    };
    const file = e.target.files[0];
    const blob = window.URL.createObjectURL(file);
    createImageHTML(blob);
    });
  }
});