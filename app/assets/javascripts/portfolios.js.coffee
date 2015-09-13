class LoadingPage
  checkForMissingPortfolio: ->
    @userMissingPortfolio = $('#user-missing-portfolio').data('github-username')
    @loadMissingPortfolio(@userMissingPortfolio) if @userMissingPortfolio
    @initializeMasonryLayout()

  loadMissingPortfolio: (githubUsername) ->
    $.ajax
      url: "/portfolios/#{githubUsername}.json"
      success: @reload
      error: @displayError

  reload: =>
    document.location = "/#{@userMissingPortfolio}"

  displayError: =>
    $('.message').hide()
    $('.flash-error').show().html(
      "There was a problem loading the portfolio for <em>#{@userMissingPortfolio}</em>. " +
      "Maybe try again?"
    )

  initializeMasonryLayout: ->
    $(window).load ->
      $('#other-projects').append('<div class="gutter-sizer"></div>')
      $('#other-projects').masonry
        itemSelector: '.project'
        transitionDuration: 0
        columnWidth: '.project'
        gutter: '.gutter-sizer'
        percentPosition: true

new LoadingPage().checkForMissingPortfolio()
