require_relative 'dialog'

class ShowStationsDialog < Dialog
  private

  def get_input
    @current_choice = nil
    clear
    show_dialog_name 'Show stations dialog'

    puts 'Here you can see the stations information.'
    show_stations
  end

  def handle_choice
    show_station_info
    puts ''
    puts 'To proceed press any key.'
    gets
    ask_again
  end

  def show_stations
    puts 'Chose the station to show info.'
    stations = @app_state.stations
    render_collection(stations)
    @current_choice = check_choice(gets.chomp).to_i
    @current_station = stations[@current_choice - 1]
  end

  def show_station_info
    clear
    @current_station.info
  end
end
