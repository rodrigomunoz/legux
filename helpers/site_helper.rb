module SiteHelper

  def t(*args)
    # Just a simple alias
    I18n.t(*args, locale: I18n.locale)
  end

  # Display tha navigation items in the top bar
  def navitems()
    nav = NavigationMenu.new(session[:privileges])
    nav.addNavigationItem("/", t("nav.HOME"))
    nav.addNavigationItem("/admin/employees", t("nav.EMPLOYEES"))
    nav.addNavigationItem("/admin/products", t("nav.PRODUCTS"))
    nav.array
  end

  # Display menu items for the user's dropdown
  def menuitems()
    menu = NavigationMenu.new(session[:privileges])
    menu.addNavigationItem("/me", t("nav.menu.EDIT_MY_PROFILE"))
    menu.addNavigationItem("/me#/password", t("nav.menu.CHANGE_MY_PASSWORD"))
    menu.addNavigationItem("/admin/users", t("nav.menu.SITE_ADMIN"))
    menu.addSeparator
    menu.addNavigationItem("/logout", t("nav.menu.LOGOUT"))
    menu.array
  end

  #TODO: How to remove dependency of writing the objects directly
  def get_db_model(url)
    case url
      when 'employees'
        return Employee
      when 'products'
        return Product
      else
        redirect to error(404)
    end
  end

  # Name of the object's fields are displayed only through
  # their name set on the .yml file corresponding to the locale
  # TODO: get it directly from the object
  def get_columns(url)
    begin
      locale = I18n.locale
      cols_hash = I18n.backend.instance_variable_get('@translations')[locale][url.to_sym][:columns]
      cols_hash.values
    rescue
      Array.new # empty array
    end
  end

  # TODO: More robust
  def get_html_response(url)
    model = get_db_model(url) # Check first if URL is valid
    @displayAllTitle = t(url + ".DISPLAY_ALL_TITLE")
    @newTitle = t(url + ".NEW_TITLE")
    @editTitle = t(url + ".EDIT_TITLE")
    @url = url
    @columns = get_columns(url)
    @keys = model.columns.to_json
    halt erb :things
  end

end