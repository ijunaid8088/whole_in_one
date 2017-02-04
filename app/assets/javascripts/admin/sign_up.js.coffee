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
    data.password.admin_password

    onError = (jqXHR, status, error) ->
      console.log error
      false

    onSuccess = (result, status, jqXHR) ->
      console.log result
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

window.initializeSignUp = ->
  onSignUp()