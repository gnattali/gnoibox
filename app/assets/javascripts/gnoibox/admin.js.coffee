window.Gnoibox ?= {}

$ ->
  $('.js-redactor').redactor
    s3: '/gnoibox/s3/put_url'
    imageGetJson: '/gnoibox/s3'
    minHeight: 200
    convertDivs: false

  $('.js-gn-freetag').select2({tags:[],tokenSeparators: [","]})

  $('.js-gn-station').select2
    width: "copy"
    minimumInputLength: 1
    initSelection: (element, callback)-> callback({id: element.val(), text: $(element).data('station-title')})
    ajax:
      url: "/gnoibox/stations.json"
      dataType: "json"
      quietMillis: 300
      cache: true
      data: (term, page)-> {q: term}
      results: (data, page)-> {results: data}

  $('.gn-async-uploadable input[type=file]').on 'change', (evt)->
    file = evt.currentTarget.files[0]
    if file
      file_input = $(evt.currentTarget)
      container = file_input.parents('.gn-form-column-image')
      $('.spinner-div', container).addClass("spinner")
      d = new Date()
      path = "tmp/"+d.toLocaleDateString("ja", {year: "numeric", month: "2-digit", day: "2-digit"}).split("/").join("-")+"/"+d.valueOf()+"-"+file.name
      params = {Key: path, ContentType: file.type, Body: file, ACL: "public-read"}
      Gnoibox.s3bucket.upload params, (err, data)->
        if data.Location
          $('.gn-remote-image-url', container).val(data.Location)
          file_input.val(null)
          
          prepareColumnImage(file_input, data.Location)
        else
          console.log err

  prepareColumnImage = (file_input, source_url)->
    return unless col_name = file_input.data('colname')
    jqxhr = $.post(file_input.data('uploadurl'), {col_name: col_name, source_url: source_url})
    jqxhr.fail (data)->
      console.log data.errors
    jqxhr.done (data)->
      file_input.attr('type', 'hidden')
      file_input.val(data.filename)

      container = file_input.parents('.gn-form-column-image')
      $('.gn-remote-image-url', container).val(null)
      $('img', container).attr('src', data.url).show()
      $('.spinner-div', container).removeClass("spinner")
