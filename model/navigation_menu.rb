class NavigationMenu

  attr_accessor :array

  def initialize(privileges)
    @array = Array.new
    @privileges = privileges
  end

  def addNavigationItem(path, title)
    # Add it only if the path is 'safe' or the user has enough privileges
    # Highest privileges are the lowest (Administrator is 0 and Basic User 1)
    if ((!path.to_s.include? "/admin/") || (Integer(@privileges) <= UserType::ADMINISTRATOR )) then
      @array.push NavigationItem.new(path, title)
    end
  end

  def addSeparator
    @array.push ""
  end

end