require_relative 'dialog'
# require_relative 'route'

class RouteCreationEntryDialog < Dialog
  private

  def get_input
    @first_station = nil
    @last_station = nil

    show_dialog_name 'Route creation entry dialog'
    stations = @app_state.stations

    if stations.empty? || stations.size < 2
      puts 'There is insuficient amount of stations to create route.'
      puts 'Please add stations to proceed.'
      puts 'You will be redirected to the main menu.'
      sleep(1)
      @menu.call
    else
      puts 'To create route choose first station'
      puts ''
      render_collection(stations)
      first = check_choice(gets.chomp).to_i
      puts 'And the last station'
      last = check_choice(gets.chomp).to_i
      @first_station = stations[first - 1]
      @last_station = stations[last - 1]
    end
  end

  def handle_choice
    create_route
    msg = "Route from #{@first_station.name} to #{@last_station.name} have been successfully created"
    ask_again(msg)
  end

  def create_route
    if @first_station.name == @last_station.name
      puts 'First and last stations should not be the same station.'
      self.call
    else
      route = Route.new(@first_station, @last_station)
      @app_state.add_route(route)
    end
  end
end
