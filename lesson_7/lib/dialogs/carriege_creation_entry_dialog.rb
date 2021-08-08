class CarriegeCreationEntryDialog < Dialog
  private

  def get_input
    @current_choice = nil
    clear
    show_dialog_name 'Carriege creation entry dialog'
    puts 'Here you can create carrieges'
    puts 'Choose the type of carriege you want to create'
    puts '1. Cargo'
    puts '2. Passanger'
    @current_choice = check_choice(gets.chomp).to_i
  end

  def handle_choice
    create_cargo_carriege if @current_choice == 1
    create_pass_carriege if @current_choice == 2
  end

  def create_cargo_carriege
    puts 'Choose the volume of the carriege.'
    @space = check_choice(gets.chomp).to_i
    carriege = CargoCarriege.new(@space)
    @app_state.add_carriege(carriege)
    @msg = 'Cargo carriege was successfully created'
  end

  def create_pass_carriege
    puts 'Choose the the number of seats in the carriege'
    @space = check_choice(gets.chomp).to_i
    carriege = PassangerCarriege.new(@space)
    @app_state.add_carriege(carriege)
  end
end