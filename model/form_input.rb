class FormInput

  attr_accessor :inputName
  attr_accessor :inputDisplay
  attr_accessor :inputType
  attr_accessor :required
  attr_accessor :instructions
  attr_accessor :value

  def initialize(inputName, inputDisplay, inputType, required, instructions, value)
    @inputName = inputName
    @inputDisplay = inputDisplay
    @inputType = inputType
    @required = required
    @instructions = instructions
    @value = value
  end

  def setValueFromParams(params)
    @value = params[@inputName]
  end

end