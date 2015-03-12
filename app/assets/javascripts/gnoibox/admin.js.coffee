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

  $('.gn-form-column-image input[type=file]').on 'change', (evt)->
    file = evt.currentTarget.files[0]
    if file
      d = new Date()
      path = "tmp/"+d.toLocaleDateString("ja", {year: "numeric", month: "2-digit", day: "2-digit"}).split("/").join("-")+"/"+d.valueOf()+"-"+file.name
      params = {Key: path, ContentType: file.type, Body: file, ACL: "public-read"}
      Gnoibox.s3bucket.upload params, (err, data)->
        if data.Location
          col = $(evt.currentTarget).parents('.gn-form-column-image')
          $('img', col).attr('src', data.Location)
          $('.gn-remote-image-url', col).val(data.Location)
          $(evt.currentTarget).val(null)
        else
          console.log err
