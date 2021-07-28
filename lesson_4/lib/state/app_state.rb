class AppState
  attr_reader :stations, :trains, :routes
  def initialize
    init_variables
  end

  def seed
    khv =  Station.new('khv')
    kms = Station.new('kms')
    msk =  Station.new('msk')
    pkn = Station.new('pkn')
    @stations << khv << kms << msk << pkn

    @routes << Route.new(khv, pkn)
    @routes << Route.new(khv, kms)
    @routes << Route.new(kms, khv)

    @trains << CargoTrain.new(number: '123')
    @trains << PassangerTrain.new(number: '133')

    @trains.first.set_route(@routes.first)
  end

  def add_station(station)
    @stations << station
  end

  def add_train(train)
    @trains << train
  end

  def add_route(route)
    @routes << route
  end

  def remove_route(route)
    @routes.delete(route)
  end

  def trains_with_route
    @trains.reject { |t| t.route.nil? }
  end

  private

  def init_variables
    @stations = []
    @trains = []
    @routes = []
  end

end
