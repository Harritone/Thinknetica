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
  end

  def handle_choice
    manage_carriege
  end

  def show_trains
    trains = @app_state.trains
    # trains.each_with_index do |train, i|
    #   puts "#{i + 1}. Train: type - #{train.type}, number -  #{train.number}," \
    #     " current speed - #{train.speed}, carrieges - #{train.carrieges.size}."
    # end
    render_collection(trains)

    @current_choice = check_choice(gets.chomp).to_i
    @current_train = trains[@current_choice - 1]
    check_train_availability
  end

  def manage_carriege
    clear
    puts 'Please, choose:'
    puts ''
    puts '1. Add carriege'
    puts '2. Remove carriege'

    @current_choice = check_choice(gets.chomp).to_i
    add_carriege_to_train if @current_choice == 1
    remove_carriege_from_train if @current_choice == 2
    self.call
  end

  def add_carriege_to_train
    carriege = Carriege.new(@current_train.type)
    @current_train.attach_carriege(carriege)
    msg = "Carriege was successfully attached to #{@current_train.number}."
    ask_again(msg)
  end

  def remove_carriege_from_train
    @current_train.detach_carriege
    msg = "Carriege was successfully detached from #{@current_train.number}."
    ask_again(msg)
  end

  def check_train_availability
    if @current_train.speed.positive?
      clear
      puts 'You should stop the train to add/remove carriege.'
      puts 'You will be redirected to the start of the dialog.'
      sleep(1)
      self.call
    end
    # do nothing
  end
end
