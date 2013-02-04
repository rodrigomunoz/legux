class FormDropdown

  attr_accessor :inputName
  attr_accessor :inputDisplay
  attr_accessor :options
  attr_accessor :instructions
  attr_accessor :value

  def initialize(inputName, inputDisplay, options, instructions, value)
    @inputName = inputName
    @inputDisplay = inputDisplay
    @options = options
    @instructions = instructions
    @value = value
  end

  def setValueFromParams(params)
    @value = params[@inputName]
  end

end