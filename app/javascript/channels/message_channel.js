import consumer from "./consumer"

consumer.subscriptions.create("MessageChannel", {
  connected() {
    // Called when the subscription is ready for use on the server
  },

  disconnected() {
    // Called when the subscription has been terminated by the server
  },

  received(data) {
    const html = `<tr><td><strong><a href="/users/${data.content.user_id}">${data.comment_user}</a> : </strong></td><td>${data.content.text}</td></tr>`;
    const messages = document.getElementById('messages');
    const newMessage = document.getElementById('comment_text');
    messages.insertAdjacentHTML('afterbegin', html);
    newMessage.value='';
    console.log(data);
  }
});
