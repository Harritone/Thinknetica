require_relative 'dialog'
# require_relative 'station'

class RouteManagementDialog < Dialog
  private

  def get_input
    @current_choice = nil
    @current_route = nil

    clear
    show_dialog_name 'Route management dialog'
    routes = @app_state.routes
    if routes.empty?
      puts "There aren't any routes to manage."
      puts "You'll be redirected to the main menu."
      sleep(1)
      @menu.call
    else
      puts 'Please, choose the route to manage.'
      puts ''
      render_collection(routes)
      @current_choice = check_choice(gets.chomp).to_i
      @current_route = routes[@current_choice - 1]
      show_options
    end
  end

  def handle_choice
    handle_management
  end

  def show_routes(routes)
    routes.each_with_index do |route, i|
      puts "#{i + 1}. Route from #{route.stations.first.name} to #{route.stations.last.name}."
    end
  end

  def show_options
    handle_current_route_nil
    clear
    puts 'Please, choose the desired option:'
    puts ''
    puts '1. Add station to the route.'
    puts '2. Remove station from the route.'
    puts '3. Remove route.'
    puts ''
    @current_choice = check_choice(gets.chomp).to_i
  end

  def handle_current_route_nil
    if @current_route.nil?
      puts 'You need to choose the route'
      sleep(1)
      self.call
    end
  end

  def handle_management
    add_station_to_route if @current_choice == 1

    remove_station_from_route if @current_choice == 2

    remove_route if @current_choice == 3

    self.call
  end

  def add_station_to_route
    clear
    puts 'Please, choose the station:'
    puts ''
    stations = @app_state.stations

    render_collection(stations)

    @current_choice = check_choice(gets.chomp).to_i
    station = stations[@current_choice - 1]
    @current_route.add_station(station)
    msg = "Station #{station.name} was successfully added to route"
    ask_again(msg)
  end

  def remove_station_from_route
    check_stations_amount
    clear
    puts 'Choose the station to remove:'
    puts ''
    stations = @current_route.stations
    stations.each_with_index do |station, i|
      puts "#{i + 1}. #{station}."
    end

    @current_choice = check_choice(gets.chomp).to_i
    station = stations[@current_choice - 1]
    @current_route.remove_station(station)
    msg = "Station #{station.name} was successfully removed from the route."
    ask_again(msg)
  end

  def remove_route
    clear
    puts 'Are you sure, you want to remove this route?'
    puts ''
    puts '1. Yes'
    puts '2. No'
    puts ''
    @current_choice = check_choice(gets.chomp).to_i
    self.call if @current_choice == 2
    @app_state.remove_route(@current_route)
    self.call
  end

  def check_stations_amount
    return unless @current_route.stations.size <= 2

    clear
    puts 'There is too low stations to remove.'
    puts 'You will be redirected to the start of the dialog.'
    sleep(1)
    self.call
  end
end
