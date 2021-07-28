class Station
  attr_reader :name, :trains

  def initialize(name)
    @name = name
    @trains = []
  end

  def to_s
    "Station #{@name}, trains on station: #{@trains.count}"
  end

  def info
    puts self.to_s
    puts ''
    puts 'Trains on station info:'
    return unless @trains.any?

    @trains.each_with_index do |train, i|
      puts "#{i + 1}. #{train}."
    end
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
  
  private

  def show_trains
    @trains.map(&:number).join(', ')
  end
end
