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
