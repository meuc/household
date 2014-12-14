`
jQuery.extend({
  getQueryParameters : function(str) {
    return (str || document.location.search).replace(/(^\?)/,'').split("&").map(function(n){return n = n.split("="),this[n[0]] = n[1],this}.bind({}))[0];
  }
});
`

$ ->

  $(window).on "load page:load", ->
    params = $.getQueryParameters()
    if params.filter
      $("#filter-tasks").val params.filter
    else
      $("#filter-tasks").val ""

  $(document).on "change", "#filter-tasks", ->
    val = $(@).val()
    if val
      Turbolinks.visit "/?filter=#{val}"
    else
      Turbolinks.visit "/"
