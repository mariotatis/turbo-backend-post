var pageLoaded = false;

function toggleTag(button) {
  event.preventDefault();
  button.classList.toggle('selected-tag');
  const selectedTags = document.querySelectorAll('.selected-tag');
  const selectedTagsArray = Array.from(selectedTags).map(tag => tag.textContent.trim());
  const selectedTagsText = selectedTagsArray.join(' | ');
  document.getElementById('post_tags').value = selectedTagsText;
}
document.addEventListener("turbo:load", function() {

  const tagButtons = document.querySelectorAll(".tag-cloud button");
  const tagsTextField = document.querySelector('input[name="post[tags]"]');
  if (tagsTextField && tagsTextField.value) {
    const selectedTags = tagsTextField.value.split(' | ');
    tagButtons.forEach(button => {
      const buttonTag = button.textContent.trim();
      if (selectedTags.includes(buttonTag)) {
        button.classList.add('selected-tag');
      }
    });
  }
});


// //toggleBookmark and toggleLike are very similar, so we can refactor them into a single function

document.addEventListener("turbo:load", function() {
  const likeButtons = document.querySelectorAll(".like-button");
  const bookmarkButtons = document.querySelectorAll(".bookmark-button");

  likeButtons.forEach(button => {
    button.addEventListener("click", toggleLike);
  });

  bookmarkButtons.forEach(button => {
    button.addEventListener("click", toggleBookmark);
  });
});

function toggleLike(event) {
  const button = event.target.closest('button');

  const postId = button.getAttribute("data-post-id");
  const liked = button.getAttribute("data-liked") === "true";

  const csrfToken = document.querySelector('meta[name="csrf-token"]').getAttribute('content');
  axios.defaults.headers.common['X-CSRF-Token'] = csrfToken;

  axios.post(`/posts/${postId}/toggle_like`)
    .then(response => {
      const newLiked = !liked;
      button.setAttribute("data-liked", newLiked);

      const heartIcon = button.querySelector('i.fa-heart');
      if (newLiked) {
        heartIcon.className = "fa-solid fa-heart";
      } else {
        heartIcon.className = "fa-regular fa-heart";
      }
    })
    .catch(error => {
      console.error("Error updating liked status:", error);
    });
}

function toggleBookmark(event) {
  const button = event.target.closest('button');
  const postId = button.getAttribute("data-post-id");
  const bookmarked = button.getAttribute("data-bookmarked") === "true";

  const csrfToken = document.querySelector('meta[name="csrf-token"]').getAttribute('content');

  axios.defaults.headers.common['X-CSRF-Token'] = csrfToken;

  axios.post(`/posts/${postId}/toggle_bookmark`)
    .then(response => {
      const newBookmarked = !bookmarked;
      button.setAttribute("data-bookmarked", newBookmarked);

      const bookmarkIcon = button.querySelector('i.fa-bookmark');
      if (newBookmarked) {
        bookmarkIcon.className = "fa-solid fa-bookmark";
      } else {
        bookmarkIcon.className = "fa-regular fa-bookmark";
      }
    })
    .catch(error => {
      console.error("Error updating bookmark status:", error);
    });
}