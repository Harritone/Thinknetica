require_relative 'dialog'
# require_relative '../station.rb'

class StationCreationEntryDialog < Dialog
  private

  def get_input
    show_dialog_name 'station creation entry dialog'
    puts 'To create station input the name'
    @name = check_choice(gets.chomp)
  end

  def handle_choice
    clear
  begin
    station = Station.new(@name)
  rescue StationValidationError => e
    puts e.message
    render_self
  end

    @app_state.add_station(station)
    msg = "Station #{station.name} was successfuly created"
    ask_again(msg)
  end
end
