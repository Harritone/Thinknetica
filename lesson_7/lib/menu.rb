class Menu
  def initialize
    @app_state = AppState.new
    @app_state.seed
    initialize_dialogs
  end

  def call
    clear
    show_instruction
    render_menu
    handle_input
  end

  private

  def show_instruction
    puts '*' * 80
    puts 'To navigate through the menu items use numbers.'
    puts 'To go back type "back"'
    puts 'To exit type "exit"'
    puts '*' * 80
  end

  def render_menu
    puts ''
    puts 'Choose the number:'
    puts '1. Create station'
    puts '2. Create train'
    puts '3. Create route'
    puts '4. Manage routes'
    puts '5. Set route to train'
    puts '6. Carriege management'
    puts '7. Move trains'
    puts '8. Show stations and trains at stations'
    puts ''
    puts '*' * 80

    @choice = check_choice(gets.chomp).to_i
  end

  def handle_input
    case @choice
    when 1
      @station_creation_entry_dialog.call
    when 2
      @train_creation_entry_dialog.call
    when 3
      @route_creation_entry_dialog.call
    when 4
      @route_management_dialog.call
    when 5
      @train_routes_management_dialog.call
    when 6
      @carriege_management_dialog.call
    when 7
      @trains_movement_dialog.call
    when 8
      @show_stations_dialog.call
    else
      rerender_menu
    end
  end

  def rerender_menu
    self.call
  end

  def check_choice(choice)
    exit if choice == 'exit'
    choice
  end

  def clear
    system 'clear'
  end

  def initialize_dialogs
    @station_creation_entry_dialog = StationCreationEntryDialog.new(@app_state, self)
    @train_creation_entry_dialog = TrainCreationEntryDialog.new(@app_state, self)
    @route_creation_entry_dialog = RouteCreationEntryDialog.new(@app_state, self)
    @route_management_dialog = RouteManagementDialog.new(@app_state, self)
    @train_routes_management_dialog = TrainRoutesManagementDialog.new(@app_state, self)
    @carriege_management_dialog = CarriegeManagementDialog.new(@app_state, self)
    @trains_movement_dialog = TrainsMovementDialog.new(@app_state, self)
    @show_stations_dialog = ShowStationsDialog.new(@app_state, self)
  end
end
