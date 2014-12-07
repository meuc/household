//= require jquery
//= require jquery_ujs
//= require turbolinks
//= require_tree .

$(function() {

  $(document).on("change", ".toggle-task-done", function() {
    var task = $(this);
    var id = task.data("task-id");

    $.ajax({
      type: "POST",
      url: "/tasks/"+id,
      data: {
        _method: "PUT",
        task: (function() {
          if (task.is(":checked")) {
            return { done: new Date() };
          } else {
            return {};
          }
        })()
      },
      dataType: "json"
    })
      .error(function() {
        alert("An error occured and the task was not updated")
        console.log("error", arguments);
      });
  });

});
