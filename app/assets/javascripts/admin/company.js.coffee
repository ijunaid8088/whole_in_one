sendAJAXRequest = (settings) ->
  token = $('meta[name="csrf-token"]')
  if token.size() > 0
    headers =
      "X-CSRF-Token": token.attr("content")
    settings.headers = headers
  xhrRequestChangeMonth = jQuery.ajax(settings)

onAddCompany = ->
  $("#add-company").on "click", ->
    $("#modal-add-company").modal("show")

onSaveCompany = ->
  $("#save-company").on "click", ->
    companyName = $("#company-name").val()
    namespace = $("#namespace").val()
    admin_id = $("#admin-id").val()

    data = {}
    data.company_name = companyName
    data.namespace = namespace
    data.admin_id =  admin_id

    onError = (result, status, jqXHR) ->
      $(".error-on-save")
        .removeClass "hidden"
        .text "#{result.responseText}"
      false

    onSuccess = (result, status, jqXHR) ->
      newAppend =
        "<tr>
          <th scope='row'>#{result.id}</th>
          <td>#{result.company_name}</td>
          <td>#{result.namespace}</td>
          <td>#{result.admin.first_name} #{result.admin.last_name}</td>
          <td>#{result.created_at}</td>
        </tr>"
      $("#admin-company tbody").append(newAppend);
      $("#modal-add-company").modal("hide")
      $(".congrats-on-save")
        .removeClass "hidden"
        .delay(200)
        .fadeIn()
        .delay(4000)
        .fadeOut()
      $(".error-on-save")
        .addClass "hidden"
        .text ""
      $("#company-name").val("")
      $("#namespace").val("")
      true

    settings =
      cache: false
      data: data
      dataType: 'json'
      error: onError
      success: onSuccess
      contentType: "application/x-www-form-urlencoded"
      type: "POST"
      url: "/company/new"

    sendAJAXRequest(settings)

onClose = ->
  $("#nothing").on "click", ->
    $(".congrats-on-save").addClass "hidden"
    $(".error-on-save")
      .addClass "hidden"
      .text ""
    $("#company-name").val("")
    $("#namespace").val("")

window.initializeCompany = ->
  onAddCompany()
  onSaveCompany()
  onClose()