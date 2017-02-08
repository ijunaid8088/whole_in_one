sendAJAXRequest = (settings) ->
  token = $('meta[name="csrf-token"]')
  if token.size() > 0
    headers =
      "X-CSRF-Token": token.attr("content")
    settings.headers = headers
  xhrRequestChangeMonth = jQuery.ajax(settings)

company_table = undefined

initializeDataTable = ->
  company_table = $("#archive_datatables").DataTable
    aaSorting: [1, "asc"]
    aLengthMenu: [
      [25, 50, 100, 200, -1]
      [25, 50, 100, 200, "All"]
    ]
    columns: [
      {data: "0", sWidth: "145px" },
      {data: "1", sWidth: "150px" },
      {data: "2", sWidth: "200px" },
      {data: "3", sWidth: "150px" },
      {data: "4", sWidth: "150px" },
    ],
    iDisplayLength: 500
    columnDefs: [
      type: "date-uk"
      targets: 'datatable-date'
    ],
    "oLanguage": {
      "sSearch": "Filter:"
    },
    initComplete: ->
      # $("#archive_datatables_length").hide()
      # $("#div-dropdown-checklist").css({"visibility": "visible", "width": "57px", "top": "0px", "left": "6px" })
      #do something here

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
      $("#archive_datatables tbody").append(newAppend);
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
  initializeDataTable()
  onAddCompany()
  onSaveCompany()
  onClose()