class PositionType
  attr_accessor :id, :name

  def initialize(options = {})
    options = options.symbolize_keys
    @id, @name = options[:id], options[:name]
  end

  def symbol
    @name.to_s.downcase.intern
  end

  def self.[](value)
    @@postionType.find { |positionType| positionType.symbol == value.to_s.downcase.intern }
  end

  def self.find(id)
    @@postionType.find { |positionType| positionType.id.to_s == id.to_s }
  end

  def self.find_all
    @@postionType.dup
  end

  @@postionType = [
    PositionType.new(:id => 0, :name => ''    ),
    PositionType.new(:id => 1, :name => 'Faculty'    ),
    PositionType.new(:id => 2, :name => 'Fellows' ),
    PositionType.new(:id => 3, :name => 'Staff'),
    PositionType.new(:id => 4, :name => 'Students'   ),
    PositionType.new(:id => 5, :name => 'Affiliated'   ),
    PositionType.new(:id => 6, :name => 'Alumni'   )
  ]
end