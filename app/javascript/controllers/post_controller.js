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
    // Extract the Turbo Stream frames from the response
    const frames = event.detail[1]?.response?.frames;
  
    // Check if frames is not undefined
    if (frames !== undefined) {
      // Find the frame targeting the 'comments_list' Turbo Frame
      const commentsListFrame = frames.find(frame => frame.id === 'comments_list');
  
      // Ensure the commentsListFrame is found
      if (commentsListFrame) {
        // Append the new comment HTML to the comments_list div
        const commentsList = document.getElementById("comments_list");
        commentsList.innerHTML += commentsListFrame.content;
  
        // Clear the comment text area using Stimulus target
        this.commentTarget.value = '';
      }
    }
  }
  
  
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