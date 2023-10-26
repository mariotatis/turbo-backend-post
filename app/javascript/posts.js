function toggleTag(button) {
  console.log("click")        
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
    console.log(selectedTags)
    tagButtons.forEach(button => {
      const buttonTag = button.textContent.trim();
      if (selectedTags.includes(buttonTag)) {
        button.classList.add('selected-tag');
      }
    });
    console.log(tagsTextField.value)
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
  const button = event.target;
  const postId = button.getAttribute("data-post-id");
  const liked = button.getAttribute("data-liked") === "true";

  const csrfToken = document.querySelector('meta[name="csrf-token"]').getAttribute('content');
  axios.defaults.headers.common['X-CSRF-Token'] = csrfToken;

  axios.post(`/posts/${postId}/toggle_like`)
    .then(response => {
      const newLiked = !liked;
      button.setAttribute("data-liked", newLiked);

      if (newLiked) {
        button.classList.add('bg-purple-200', 'text-purple-600');
        button.classList.remove('border', 'border-purple-100');
      } else {
        button.classList.remove('bg-purple-200', 'text-purple-600');
        button.classList.add('border', 'border-purple-100');
      }
    })
    .catch(error => {
      console.error("Error updating liked status:", error);
    });
}

function toggleBookmark(event) {
  const button = event.target;
  const postId = button.getAttribute("data-post-id");
  const bookmarked = button.getAttribute("data-bookmarked") === "true";

  const csrfToken = document.querySelector('meta[name="csrf-token"]').getAttribute('content');

  axios.defaults.headers.common['X-CSRF-Token'] = csrfToken;

  axios.post(`/posts/${postId}/toggle_bookmark`)
    .then(response => {
      const newBookmarked = !bookmarked;
      button.setAttribute("data-bookmarked", newBookmarked);

      if (newBookmarked) {
        button.classList.add('bg-purple-200', 'text-purple-600');
        button.classList.remove('border', 'border-purple-100');
      } else {
        button.classList.remove('bg-purple-200', 'text-purple-600');
        button.classList.add('border', 'border-purple-100');
      }
    })
    .catch(error => {
      console.error("Error updating bookmark status:", error);
    });
}