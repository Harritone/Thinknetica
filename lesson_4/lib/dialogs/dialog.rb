# This is an abstract class, should never be instantiated

class Dialog
  def initialize(app_state, menu)
    @app_state = app_state
    @menu = menu
    @current_choice = nil
  end

  def call
    get_input
    handle_choice
  end

  protected

  def get_input
    # do nothing
  end

  def handle_choice(choice)
    # do nothing
  end

  def render_collection(collection)
    return unless collection.is_a?(Array)

    collection.each_with_index do |el, i|
      puts "#{i + 1}. #{el}."
    end
  end

  def check_choice(choice)
    @menu.call if choice == 'menu'
    self.call if choice == 'back'
    exit if choice == 'exit'
    choice
  end

  def ask_again(msg = '')
    clear
    puts msg
    puts '*' * 80
    puts 'Do you want to repeat the last action?'
    puts '1. Yes'
    puts '2. No'
    choice = check_choice(gets.chomp)
    choice.to_i == 1 ? self.call : @menu.call
  end

  def clear
    system 'clear'
  end

  def show_dialog_name(name)
    clear
    puts '*' * 80
    puts name
    puts '*' * 80
  end
end
