// Add an event listener to the report button
document.getElementById("reportButton").addEventListener("click", function() {
    // Get the post ID from the data attribute of the report button
    const postId = this.getAttribute("data-postid");
    // Set the value of the hidden input field 'postid'
    document.getElementById("postid").value = postId;

    // Get the selected violations from the checkboxes
    const violations = [];
    const checkboxes = document.querySelectorAll("input[name='violation']:checked");
    checkboxes.forEach((checkbox) => {
      violations.push(checkbox.value);
    });

    // Get the value from the 'Others' text area
    const othersValue = document.getElementById("exampleTextarea").value;

    // Create a form and set its attributes
    const form = document.createElement("form");
    form.method = "post";
    form.action = "submitreports.asp";

    // Add a hidden input field to store the post ID
    const postIdInput = document.createElement("input");
    postIdInput.type = "hidden";
    postIdInput.name = "postid";
    postIdInput.value = postId;
    form.appendChild(postIdInput);

    // Add the selected violations to the form
    violations.forEach((violation) => {
      const violationInput = document.createElement("input");
      violationInput.type = "hidden";
      violationInput.name = "violation";
      violationInput.value = violation;
      form.appendChild(violationInput);
    });

    // Add the 'Others' value to the form
    const othersInput = document.createElement("input");
    othersInput.type = "hidden";
    othersInput.name = "others";
    othersInput.value = othersValue;
    form.appendChild(othersInput);

    // Append the form to the document body and submit it
    document.body.appendChild(form);
    form.submit();
  });

  // Update the report button data-postid attribute
  const reportButtons = document.querySelectorAll(".report-button");
  reportButtons.forEach((button) => {
    button.addEventListener("click", function() {
      const postId = this.getAttribute("data-postid");
      document.getElementById("reportButton").setAttribute("data-postid", postId);
    });
  });