module FormsHelper

  def createUserForm(params = nil)
    @form = Form.new(t("users.CREATE_USERS"), "/secure/users/create")
    @form.addInput(:username, t("login.USERNAME"), "text", true, t("users.USERNAME_INSTRUCTIONS"))
    @form.addInput(:password, t("login.PASSWORD"), "password", true)
    @form.addInput(:passwordconfirm, t("users.CONFIRM_PASSWORD"), "password", true)
    @form.addInput(:displayname, t("users.DISPLAY_NAME"), "text", true)
    @form.addInput(:email, t("users.E_MAIL"), "text", false)

    # TODO: Add dropdown to select user type
    @form.addButton(t("users.CREATE_USER"))

    @form.bindWithParams(params)
  end

  def updateDisplayNameForm
    @form = Form.new(t("nav.menu.EDIT_MY_PROFILE"), "/secure/me/editprofile")
    @form.addInput(:displayname, t("me.UPDATE_DISPLAY_NAME"), "text", true, "", session[:identityDisplay])
    @form.addButton(t("me.UPDATE"))
  end

  def updatePasswordForm
    @form = Form.new(t("nav.menu.CHANGE_MY_PASSWORD"), "/secure/me/changepassword")
    @form.addInput(:password, t("login.PASSWORD"), "password", true)
    @form.addInput(:passwordconfirm, t("users.CONFIRM_PASSWORD"), "password", true)
    @form.addButton(t("me.UPDATE"))
  end

end