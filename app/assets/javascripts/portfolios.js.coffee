class LoadingPage
  checkForMissingPortfolio: ->
    @userMissingPortfolio = $('#user-missing-portfolio').data('github-username')
    @loadMissingPortfolio(@userMissingPortfolio) if @userMissingPortfolio

  loadMissingPortfolio: (githubUsername) ->
    $.ajax
      url: "/portfolios/#{githubUsername}.json"
      success: @reloadPage
      error: @displayError

  reloadPage: ->
    document.location.reload true

  displayError: =>
    $('.message').hide()
    $('.flash-error').show().html(
      "There was a problem loading the portfolio for <em>#{@userMissingPortfolio}</em>. " +
      "Maybe try again?"
    )

new LoadingPage().checkForMissingPortfolio()
