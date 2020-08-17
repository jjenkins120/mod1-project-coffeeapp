require_relative '../config/environment'


puts "Welcome to K&J Cafe!"



def welcome
    prompt = TTY::Prompt.new
    prompt.select("Please choose from one of the following options:") do |menu|
        menu.choice "Order", -> { Order.new_order }
        menu.choice "Sign In", -> { User.sign_in }
        menu.choice "Create Account", -> { User.create_account }
        menu.choice "Exit", -> { exit }
    end 
end

welcome

