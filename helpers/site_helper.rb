module SiteHelper

  def t(*args)
    # Just a simple alias
    I18n.t(*args, locale: I18n.locale)
  end

  # Display tha navigation items in the top bar
  def navitems()
    @items = Array.new
    @items.push NavigationItem.new("/", t("nav.HOME"))
    @items.push NavigationItem.new("/secure/place", t("nav.SECRET"))
    @items
  end

end