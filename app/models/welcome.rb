def exit_method
    puts "Thank you. Have a great day. Goodbye!"
    User.all.each {|user_instance| user_instance.update(signed_in?: false)}
    sleep (1.5)
    exit
end

def welcome1
    system "clear"
    #prompt = TTY::Prompt.new
    $prompt.select("Please choose from one of the following options:") do |menu|
        menu.choice "Order", -> { Order.new_order }
        menu.choice "Sign In", -> { User.sign_in }
        menu.choice "Create Account", -> { User.create_account }
        menu.choice "Exit", -> { exit_method }
    end
end

def welcome2
    system "clear"
    #prompt = TTY::Prompt.new
    $prompt.select("Please choose from one of the following options:") do |menu|
        menu.choice "Order", -> { Order.new_order }
        menu.choice "Account Information", -> { account_method }
        menu.choice "Sign Out", -> { User.sign_out }
        menu.choice "Exit", -> { exit_method }
    end
end