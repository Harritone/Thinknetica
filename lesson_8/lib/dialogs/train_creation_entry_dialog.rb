require_relative 'dialog'

class TrainCreationEntryDialog < Dialog
  private

  def get_input
    clear
    puts '*' * 80
    puts self.class.name
    puts 'train creation entry dialog'
    puts '*' * 80
    puts 'To create train input the number'
    @number = check_choice(gets.chomp)
    puts 'And type(cargo or passanger)'
    @type = check_choice(gets.chomp)
  end

  def handle_choice
  begin
    train = @type == 'cargo' ? 
      CargoTrain.new(number: @number) :
      PassangerTrain.new(number: @number)
  rescue Train::TrainNumberValidationError => e
    puts e.message
    redirect_self
  rescue Train::TrainTypeValidationError => e
    puts e.message
    redirect_self
  end

    @app_state.add_train(train)
    msg = "#{train.type} train with number #{@number} " \
      'was successfuly created'

    ask_again(msg)
  end
end
