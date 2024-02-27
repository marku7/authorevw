
// Initialize liked and disliked objects from local storage
var liked = JSON.parse(localStorage.getItem('liked')) || {};
var disliked = JSON.parse(localStorage.getItem('disliked')) || {};

// Update the like and dislike counts on page load
updateCounts();

function updateCounts() {
  for (var postId in liked) {
    document.getElementById('likeCount_' + postId).innerHTML = liked[postId];
  }

  for (var postId in disliked) {
    document.getElementById('dislikeCount_' + postId).innerHTML = disliked[postId];
  }
}

// Function to handle the like button click
function like(postId) {
  var likeCount = parseInt(document.getElementById('likeCount_' + postId).innerHTML);
  var dislikeCount = parseInt(document.getElementById('dislikeCount_' + postId).innerHTML); // Add this line

  if (liked[postId]) {
    // User wants to undo the like
    likeCount--;
    delete liked[postId];
  } else {
    // User wants to like
    likeCount++;
    liked[postId] = likeCount;

    // If the user has previously disliked, undo the dislike
    if (disliked[postId]) {
      var dislikeCount = parseInt(document.getElementById('dislikeCount_' + postId).innerHTML);
      dislikeCount--;
      delete disliked[postId];
      document.getElementById('dislikeCount_' + postId).innerHTML = dislikeCount;
    }
  }

  document.getElementById('likeCount_' + postId).innerHTML = likeCount;
  updateLocalStorage();
  updateLikesDislikes(postId, likeCount, dislikeCount); // Call the function to update the database
}

// Function to handle the dislike button click
function dislike(postId) {
  var dislikeCount = parseInt(document.getElementById('dislikeCount_' + postId).innerHTML);
  var likeCount = parseInt(document.getElementById('likeCount_' + postId).innerHTML); // Add this line

  if (disliked[postId]) {
    // User wants to undo the dislike
    dislikeCount--;
    delete disliked[postId];
  } else {
    // User wants to dislike
    dislikeCount++;
    disliked[postId] = dislikeCount;

    // If the user has previously liked, undo the like
    if (liked[postId]) {
      var likeCount = parseInt(document.getElementById('likeCount_' + postId).innerHTML);
      likeCount--;
      delete liked[postId];
      document.getElementById('likeCount_' + postId).innerHTML = likeCount;
    }
  }

  document.getElementById('dislikeCount_' + postId).innerHTML = dislikeCount;
  updateLocalStorage();
  updateLikesDislikes(postId, likeCount, dislikeCount); // Call the function to update the database
}

// Function to update the local storage with the current liked and disliked counts
function updateLocalStorage() {
  localStorage.setItem('liked', JSON.stringify(liked));
  localStorage.setItem('disliked', JSON.stringify(disliked));
}

// Function to update the likes and dislikes in the database
function updateLikesDislikes(postId, likeCount, dislikeCount) {
  // Send an AJAX request to the server to update the database
  var xhr = new XMLHttpRequest();
  xhr.open('POST', 'updatelike.asp', true);
  xhr.setRequestHeader('Content-Type', 'application/x-www-form-urlencoded');
  xhr.onreadystatechange = function () {
    if (xhr.readyState === 4 && xhr.status === 200) {
      // Handle the response from the server if needed
      console.log(xhr.responseText);
    }
  };
  xhr.send('postId=' + postId + '&likeCount=' + likeCount + '&dislikeCount=' + dislikeCount);
}