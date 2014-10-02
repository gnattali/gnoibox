$ ->
  $('.js-redactor').redactor
    s3: '/gnoibox/s3/put_url'
    imageGetJson: '/gnoibox/s3'
    minHeight: 200
    convertDivs: false

  $('.js-gn-freetag').select2({tags:[],tokenSeparators: [","]})
