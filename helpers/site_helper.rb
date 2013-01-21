module SiteHelper

  def t(*args)
    # Just a simple alias
    I18n.t(*args, locale: I18n.locale)
  end

  # Display tha navigation items in the top bar
  def navitems()
    @items = Array.new
    @items.push NavigationItem.new("/", t("nav.HOME"))
    @items
  end

  # Display menu items for the user's dropdown
  def menuitems()
    @items = Array.new
    @items.push NavigationItem.new("/secure/me/editprofile", t("nav.menu.EDIT_MY_PROFILE"))
    @items.push NavigationItem.new("/secure/me/changepassword", t("nav.menu.CHANGE_MY_PASSWORD"))
    @items.push NavigationItem.new("/secure/users/create", t("nav.menu.SITE_ADMIN"))
    @items.push ""
    @items.push NavigationItem.new("/logout", t("nav.menu.LOGOUT"))
    @items
  end

end