import { Controller } from "@hotwired/stimulus"

export default class extends Controller {
  connect() {
    const dataIdAttribute = this.element.attributes.getNamedItem("data-id");
    
    if (dataIdAttribute) {
      const dataIdValue = dataIdAttribute.value;
      fetchPageData(dataIdValue) 
    }
  }

  static targets = ["comment"];

  removeComment(event) {
    const commentId = this.element.attributes.getNamedItem("data-comment-id").value;
    commentCountMinusOne('commentCountList');

    const commentElement = document.getElementById(`comment-${commentId}`);
    commentElement.classList.add('fade-out');
    commentElement.addEventListener('animationend', () => {
      commentElement.remove();
    }, { once: true });
  }

  addComment(event) {
    const frames = event.detail[1]?.response?.frames;
    commentCountPlusOne('commentCountList');

    if (frames !== undefined) {
      const commentsListFrame = frames.find(frame => frame.id === 'comments_list');
      if (commentsListFrame) {
        const commentsList = document.getElementById("comments_list");
        commentsList.innerHTML += commentsListFrame.content;
        this.commentTarget.value = '';
      }
    }
  }
  
  
}

function commentCountPlusOne(id){
  const commentCountElement = document.getElementById(id);
  commentCountElement.innerHTML = parseInt(commentCountElement.textContent) + 1;
}

function commentCountMinusOne(id){
  const commentCountElement = document.getElementById(id);
  commentCountElement.innerHTML = parseInt(commentCountElement.textContent) - 1;
}

function fetchPageData(post_id) {
  //const post_id = post_id;
  axios.get('/posts/fetch_page/' + post_id, {
    headers: {
      'X-Requested-With': 'XMLHttpRequest', 
      'Accept': 'text/javascript'
    }
  })
  .then(function (response) {
    const pageDataElement = document.getElementById('pageData');
    pageDataElement.innerHTML = response.data;
  })
  .catch(function (error) {
    console.log('Error fetching page data', error);
  });
}