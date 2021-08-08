class AppState
  attr_reader :stations, :trains, :routes, :carrieges
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

    cargo_car = CargoCarriege.new(30)
    cargo_car1 = CargoCarriege.new(30)
    pass_car = PassangerCarriege.new(30)
    pass_car1 = PassangerCarriege.new(30)
    @carrieges << cargo_car1 << pass_car1

    cargo = CargoTrain.new(number: '123-22')
    cargo.attach_carriege(cargo_car)
    pass = PassangerTrain.new(number: '133-22')
    pass.attach_carriege(pass_car)
    @trains << cargo << pass

    @trains.first.set_route(@routes.first)
    @trains.last.set_route(@routes.last)
  end

  def add_carriege(car)
    @carrieges << car
  end

  def remove_carriege(car)
    @carrieges.delete(car)
  end

  def get_carrieges_by_type(type)
    @carrieges.select { |c| c.type == type }
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
    @carrieges = []
  end
end
