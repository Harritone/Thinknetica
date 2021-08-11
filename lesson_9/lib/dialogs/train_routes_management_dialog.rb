require_relative 'dialog'
# require_relative 'station'

class TrainRoutesManagementDialog < Dialog
  private

  def get_input
    @current_choice = nil
    @current_route = nil
    @current_train = nil
    clear
    show_dialog_name 'Train routes management dialog'

    puts 'Here you can set route to train.'
    show_trains
    clear
    show_routes
  end

  def handle_choice
    set_route_to_train
    msg = 'Route was set.'
    ask_again(msg)
  end

  def show_trains
    trains = @app_state.trains
    puts 'Choose the train to set route to.'

    render_collection(trains)

    @current_choice = check_choice(gets.chomp).to_i
    @current_train = trains[@current_choice - 1]
  end

  def show_routes
    routes = @app_state.routes
    puts 'Choose the route.'

    render_collection(routes)

    @current_choice = check_choice(gets.chomp).to_i
    @current_route = routes[@current_choice - 1]
  end

  def set_route_to_train
    @current_train.set_route(@current_route)
  end
end
