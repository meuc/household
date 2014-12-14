$ ->

  $(document).on "change", ".toggle-task-done", ->
    task = $(@)
    id = task.data "task-id"
    $.ajax
      type: "POST"
      url: "/tasks/#{id}"
      dataType: "json"
      data:
        _method: "PUT"
        task: (->
          if task.is ":checked"
            { done: new Date() }
          else
            {}
        )()
    .error ->
      task.removeAttr "checked"
      alert "An error occured and the task was not updated"
      console.log "error", arguments
