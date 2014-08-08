ready = ->
  Stripe.setPublishableKey($('meta[name="stripe-key"]').attr('content'))
  subscription.setupForm()

subscription =
  setupForm: ->
    $('.edit_subscription').submit ->
      $('input[type=submit]').attr('disabled', true)
      subscription.processCard()
      false
  
  processCard: ->
    card =
      number: $('#card_number').val()
      cvc: $('#card_code').val()
      expMonth: $('#card_month').val()
      expYear: $('#card_year').val()
    Stripe.createToken(card, subscription.handleStripeResponse)
  
  handleStripeResponse: (status, response) ->
    if status == 200
      $('#subscription_stripe_card_token').val(response.id)
      $('.edit_subscription')[0].submit()
    else
      $('#stripe_error').text(response.error.message)
      $('input[type=submit]').attr('disabled', false)

$(document).ready(ready)
$(document).on('page:load', ready)