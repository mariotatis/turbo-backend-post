import { Controller } from "@hotwired/stimulus"

export default class extends Controller {
  connect() {
    // Get the data-id attribute
    const dataIdAttribute = this.element.attributes.getNamedItem("data-id");

    if (dataIdAttribute) {
      // Retrieve the value
      const dataIdValue = dataIdAttribute.value;
      fetchPageData(dataIdValue) 
      //console.log(dataIdValue);
    }
  }
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