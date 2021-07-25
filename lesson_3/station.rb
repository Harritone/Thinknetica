class Station
  attr_reader :name, :trains

  def initialize(name)
    @name = name
    @trains = []
  end

  def take_train(train)
    @trains << train
  end

  def get_trains_by_type
    trains = Hash.new(0)
    @trains.each do |train|
      train.type == 'cargo' ? trains[:cargo] += 1 : trains[:pass] += 1
    end
    trains
  end

  def depart_train(train)
    @trains.delete(train)
  end
end
