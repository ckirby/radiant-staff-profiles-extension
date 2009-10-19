class PositionTypes
  attr_accessor :id, :name

  def initialize(options = {})
    options = options.symbolize_keys
    @id, @name = options[:id], options[:name]
  end

  def symbol
    @name.to_s.downcase.intern
  end

  def self.[](value)
    @@postionTypes.find { |positionType| positionType.symbol == value.to_s.downcase.intern }
  end

  def self.find(id)
    @@postionTypes.find { |positionType| positionType.id.to_s == id.to_s }
  end

  def self.find_all
    @@postionTypes.dup
  end

  @@postionTypes = [
    PositionTypes.new(:id => 0,   :name => ''    ),
    PositionTypes.new(:id => 1,   :name => 'Faculty'    ),
    PositionTypes.new(:id => 2,  :name => 'Fellows' ),
    PositionTypes.new(:id => 3, :name => 'Staff'),
    PositionTypes.new(:id => 4, :name => 'Students'   ),
    PositionTypes.new(:id => 5, :name => 'Affiliated'   ),
    PositionTypes.new(:id => 6, :name => 'Alumni'   )
  ]
en