sendAJAXRequest = (settings) ->
  token = $('meta[name="csrf-token"]')
  if token.size() > 0
    headers =
      "X-CSRF-Token": token.attr("content")
    settings.headers = headers
  xhrRequestChangeMonth = jQuery.ajax(settings)

onSignUp = ->
  $("#admin_sign_up").on "click", ->    
    first_name = $("#first_name").val()
    last_name = $("#last_name").val()
    admin_email = $("#admin_email").val()
    admin_password = $("#admin_password").val()

    data = {}
    data.first_name = first_name
    data.last_name = last_name
    data.email = admin_email
    data.password = admin_password

    onError = (result, status, jqXHR) ->
      $.notify("#{result.responseText}", "error")
      false

    onSuccess = (result, status, jqXHR) ->
      clearForm()
      $.notify("Hello #{result.first_name} #{result.last_name}! Your account has been created. Please login", "success")
      true

    settings =
      cache: false
      data: data
      dataType: 'json'
      error: onError
      success: onSuccess
      contentType: "application/x-www-form-urlencoded"
      type: "POST"
      url: "/admin/new"

    sendAJAXRequest(settings)

clearForm = ->
    $("#first_name").val("")
    $("#last_name").val("")
    $("#admin_email").val("")
    $("#admin_password").val("")

window.initializeSignUp = ->
  onSignUp()