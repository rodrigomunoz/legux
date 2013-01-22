class NavigationItem

  attr_accessor :path
  attr_accessor :title

  def initialize(path, title)
    @path = path
    @title = title
  end

end