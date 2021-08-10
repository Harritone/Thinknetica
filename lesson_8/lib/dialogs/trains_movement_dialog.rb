require_relative 'dialog'
# require_relative 'station'

class TrainsMovementDialog < Dialog
  private

  def get_input
    @current_choice = nil
    clear
    show_dialog_name 'Trains movement dialog'

    puts 'Here you can move trains back and forth.'
    show_trains
    ask_to_move
  end

  def handle_choice
    move_train
    msg = 'Train departed'
    ask_again(msg)
  end

  def show_trains
    @menu.call if no_trains

    puts 'Choose the train.'
    puts ''
    trains = @app_state.trains_with_route
    render_collection(trains)

    @current_choice = check_choice(gets.chomp).to_i
    @current_train = trains[@current_choice - 1]
  end

  def ask_to_move
    clear
    puts 'Where do you want to move the train?'
    puts ''
    puts '1. Next station.'
    puts '2. Previous station.'
    puts '3. Stay where it is.'

    @move_to = check_choice(gets.chomp).to_i
  end

  def move_train
    @current_train.move_forward if @move_to == 1
    @current_train.move_backward if @move_to == 2

    self.call
  end

  def no_trains
    return false if @app_state.trains_with_route.count.positive?

    puts 'You need to create trains and/or assign route to ask it to move.'
    sleep(1)
    true
  end
end
