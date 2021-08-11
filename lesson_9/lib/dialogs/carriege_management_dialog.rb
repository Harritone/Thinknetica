require_relative 'dialog'
# require_relative 'station'

class CarriegeManagementDialog < Dialog
  private

  def get_input
    @current_choice = nil
    clear
    show_dialog_name 'Carrige management dialog'
    puts 'Here you can attach to or detach carriege from the train'
    puts 'Choose the train:'
    puts ''
    show_trains
    puts 'Choose the carriege'
    # show_carrieges
  end

  def handle_choice
    manage_carriege
  end

  def show_trains
    trains = @app_state.trains
    render_collection(trains)

    @current_choice = check_choice(gets.chomp).to_i
    @current_train = trains[@current_choice - 1]
    @current_type = @current_train.type
    check_train_availability
  end

  def show_carrieges
    puts 'Choose the carriege'
    carrieges = @app_state.get_carrieges_by_type(@current_type)

    render_collection(carrieges)
    @current_carriege = check_choice(gets.chomp).to_i
  end

  def manage_carriege
    clear
    puts 'Please, choose:'
    puts ''
    puts '1. Add carriege'
    puts '2. Remove carriege'
    puts '3. Fill the space of the carriege'

    @current_choice = check_choice(gets.chomp).to_i
    add_carriege_to_train if @current_choice == 1
    remove_carriege_from_train if @current_choice == 2
    fill_space if @current_choice == 3
    self.call
  end

  def fill_space
    carrieges = @current_train.carrieges
    puts 'Choose the carriege to fill'
    render_collection(carrieges)
    idx = check_choice(gets.chomp).to_i
    @current_carriege = carrieges[idx - 1]
    @current_type == :cargo ? fill_cargo_carriege : fill_pass_carriege
  end

  def fill_cargo_carriege
    puts 'Input the volume to fill'
    space = check_choice(gets.chomp).to_i
    @current_carriege.add_volume(space)
    puts "Carriege was filled by #{space}!"
    sleep(1)
  end

  def fill_pass_carriege
    @current_carriege.take_seat
    puts '1 seat was taken!'
    sleep(1)
  end

  def add_carriege_to_train
    show_carrieges
    @app_state.remove_carriege(@current_carriege)
    @current_train.attach_carriege(@current_carriege)
    msg = "Carriege was successfully attached to #{@current_train.number}."
    ask_again(msg)
  end

  def remove_carriege_from_train
    carriege = @current_train.detach_carriege
    app_state.add_carriege(carriege)
    msg = "Carriege was successfully detached from #{@current_train.number}."
    ask_again(msg)
  end

  def check_train_availability
    return unless @current_train.speed.positive?

    clear
    puts 'You should stop the train to add/remove carriege.'
    puts 'You will be redirected to the start of the dialog.'
    sleep(1)
    self.call
  end
end
