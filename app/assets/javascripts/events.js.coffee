highlightNavigation = ->
  navigation = $('[data-overview-navigation]')

  activePage = window.location.pathname.split('/')[3]

  if activePage == 'standings'
    $('[data-standings]').addClass 'active'

  if window.location.pathname.split('/').length == 3
    $('[data-overview]').addClass 'active'

$ ->
  highlightNavigation()

$(document).on 'page:change': ->
  highlightNavigation()
