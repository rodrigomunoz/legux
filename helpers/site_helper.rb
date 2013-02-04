module SiteHelper

  def t(*args)
    # Just a simple alias
    I18n.t(*args, locale: I18n.locale)
  end

  # Display tha navigation items in the top bar
  def navitems()
    nav = NavigationMenu.new(session[:privileges])
    nav.addNavigationItem("/", t("nav.HOME"))
    nav.array
  end

  # Display menu items for the user's dropdown
  def menuitems()
    menu = NavigationMenu.new(session[:privileges])
    menu.addNavigationItem("/secure/me/editprofile", t("nav.menu.EDIT_MY_PROFILE"))
    menu.addNavigationItem("/secure/me/changepassword", t("nav.menu.CHANGE_MY_PASSWORD"))
    menu.addNavigationItem("/secure/users/admin/create", t("nav.menu.SITE_ADMIN"))
    menu.addSeparator
    menu.addNavigationItem("/logout", t("nav.menu.LOGOUT"))
    menu.array
  end

end