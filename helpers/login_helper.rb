module LoginHelper

  def username
    session[:identity] ? session[:identity] : t("STRANGER")
  end

end