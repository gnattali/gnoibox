$ ->
  $('.gn-form-confirmation-text').hide()

  showConfirmationText = (elm, val)->
    $(elm).hide()
    $(elm).after("<span class='gn-form-column-preview'>"+val+"</span>")
  
  $('.gn-form-confirmable').on 'submit', (evt)->
    form = $(evt.currentTarget)
    if !form.data('confirmed')
      evt.preventDefault()
      evt.stopPropagation()

      form.css({opacity: 0}, 100)
      
      $('.gn-form-column', form).each (i,elm)-> showConfirmationText(elm, $(elm).val().replace(/\n/g, "<br />"))
      $('.gn-form-column-radio').each (i, elm)->
        showConfirmationText(elm, $("[type='radio']:checked", elm).parent('label').text())
      $('.gn-form-column-checkbox').each (i, elm)->
        texts = jQuery.map $(":checkbox:checked", elm).get(), (box)-> $(box).parent('label').text()
        showConfirmationText elm, texts.join("、")

      $('.column-hint').hide()
      $('.column-error').hide()

      submit = $('input[type="submit"]', form)
      submit.data('prevtext', submit.val()).val('送信する')

      if $('.gn-form-confirmable-back').length==0
        backButton = $("<input type='button' value='戻る' class='gn-form-confirmable-back'>")
        backButton.addClass(submit.attr('class'))
        submit.before(backButton)
      $('.gn-form-confirmable-back').show()
      
      if $('.gn-form-confirmation-text').length==0
        form.prepend($('<div class="gn-form-confirmation-text">'))
        $('.gn-form-confirmation-text').html('下記内容でよろしければ「送信する」ボタンを押してください')
      $('.gn-form-confirmation-text').show()

      form.data('confirmed', true)

      $('body').animate {scrollTop: form.offset().top}, 500, -> form.delay(100).animate({opacity: 1})

      
  $('.gn-form-confirmable').on 'click', '.gn-form-confirmable-back', (evt)->
    form = $('.gn-form-confirmable')
    submit = $('input[type="submit"]', form)

    form.css({opacity: 0})

    $('.gn-form-column, .gn-form-column-radio, .gn-form-column-checkbox').show()
    $('.gn-form-column-preview').remove()
    $('.gn-form-confirmation-text').hide()

    $('.column-hint').show()
    $('.column-error').show()

    submit.val(submit.data('prevtext'))
    $(evt.currentTarget).hide()

    form.data('confirmed', false)

    form.animate({opacity: 1})
