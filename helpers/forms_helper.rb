module FormsHelper

  def createUserForm(params = nil)
    @form = Form.new(t("users.CREATE_USERS"), "/users/create")
    @form.addInput(:username, t("login.USERNAME"), InputType::TEXT_INPUT, true, t("users.USERNAME_INSTRUCTIONS"))
    @form.addInput(:password, t("login.PASSWORD"), InputType::PASSWORD_INPUT, true)
    @form.addInput(:passwordconfirm, t("users.CONFIRM_PASSWORD"), InputType::PASSWORD_INPUT, true)
    @form.addInput(:displayname, t("users.DISPLAY_NAME"), InputType::TEXT_INPUT, true)
    @form.addInput(:email, t("users.E_MAIL"), InputType::TEXT_INPUT, false)
    @form.addDropdown(:type, t("users.TYPE"),
                      Hash[t("users.BASIC_USER"), UserType::BASIC_USER,
                           t("users.SYSTEM_ADMINISTRATOR"), UserType::ADMINISTRATOR])

    @form.addButton(t("users.CREATE_USER"))

    @form.bindWithParams(params)
  end

  def editUserForm(params = nil)
    @form = Form.new(t("users.EDIT_USER"), "/users/edit/")
    @form.addInput(:username, t("login.USERNAME"), "text", true, t("users.USERNAME_INSTRUCTIONS"))
    @form.addInput(:displayname, t("users.DISPLAY_NAME"), "text", true)
    @form.addInput(:email, t("users.E_MAIL"), "text", false)
    @form.addDropdown(:type, t("users.TYPE"),
                      Hash[t("users.BASIC_USER"), UserType::BASIC_USER,
                           t("users.SYSTEM_ADMINISTRATOR"), UserType::ADMINISTRATOR])

    @form.addButton(t("users.EDIT_USER"))

    @form.bindWithParams(params)
  end

  def updatePasswordForm
    @form = Form.new(t("nav.menu.CHANGE_MY_PASSWORD"), "/me/changepassword")
    @form.addInput(:password, t("login.PASSWORD"), "password", true)
    @form.addInput(:passwordconfirm, t("users.CONFIRM_PASSWORD"), "password", true)
    @form.addButton(t("me.UPDATE"))
  end

end