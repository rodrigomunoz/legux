class Form

  attr_accessor :title
  attr_accessor :action
  attr_accessor :inputs
  attr_accessor :buttons

  def initialize(title, action)
    @title = title
    @action = action
    @inputs = Array.new
    @buttons = Array.new
  end

  def addInput(inputName, inputDisplay, inputType, required, instructions = "", value = "")
    @inputs.push FormInput.new(inputName, inputDisplay, inputType, required, instructions, value)
  end

  def addButton(label)
    @buttons.push label
  end

  def bindWithParams(params)
    if !params.nil? then
      for item in @inputs do
        item.setValueFromParams(params)
      end
    end
  end

end