class Menu
  constructor:(menu, menu_toggle) ->
    @$menu = $(menu)
    @$menu_toggle = $(menu_toggle)

    observe_event = if 'onorientationchange' in window then 'orientationchange' else 'resize'

    $(window).on observe_event, @close_menu
    @$menu_toggle.on 'click', @toggle_menu
    @$menu.find('a').on 'click', @toggle_menu

  close_menu: (event) =>
    if @$menu.hasClass('menu-open')
      @toggle_menu event

  toggle_menu: (event) =>
    @$menu.toggleClass 'menu-open'
    @$menu_toggle.toggleClass 'toggle-open'

module.exports =
  Menu: Menu
