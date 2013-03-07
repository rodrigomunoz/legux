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

  def to_json(*a)
    {
        'json_class'   => self.class.name,
        'type'         => InputType::DROPDOWN_INPUT,
        'name'         => @inputName,
        'label'        => @inputDisplay,
        'instructions' => @instructions,
        'options'      => @options,
        'value'        => @value,
    }.to_json(*a)
  end

  def setValueFromParams(params)
    @value = params[@inputName]
  end

end