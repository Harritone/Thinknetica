class Station
  attr_reader :name, :trains

  def initialize(name)
    @name = name
    @trains = []
  end

  def take_train(train)
    @trains << train
  end

  def get_trains_by_type(type)
    @trains.select { |train| train.type == type }
  end

  def get_trains_amount_by_type(type)
    get_trains_by_type(type).count
  end

  def depart_train(train)
    @trains.delete(train)
  end
end
