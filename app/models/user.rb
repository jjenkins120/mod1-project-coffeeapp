class User < ActiveRecord::Base
    has_many :orders
    has_many :drinks, through: :orders

    def self.sign_in
        puts "Please enter username or type 'exit' to exit"
        username = gets.chomp
        if username == "exit"
            welcome
        else
            if user = User.find_by(username: username)
                user.enter_password
            else
                puts "User does not exist"
                sleep (2)
                welcome
            end
        end
    end

    def self.sign_out
        #prompt = TTY::Prompt.new
        $prompt.select("Are you sure that you want to sign out?") do |menu|
            menu.choice "Yes", -> {User.which_user.update(signed_in?:false);welcome}
            menu.choice "No", -> {welcome}
        end
        
    end

    def enter_password
        #prompt = TTY::Prompt.new
        password = $prompt.mask("Please enter password:")
        if password == self.password 
            self.update(signed_in?: true)
            puts "You are signed in!"
            sleep (2)
            welcome
        else
            puts "Password incorrect"
            User.sign_in
        end
    end

    def self.create_account
        puts "Please enter a username or type 'exit' to return to the main menu:"
        username = gets.chomp
        if username == "exit"
            welcome
        elsif    
            self.find_by(username: username.downcase)
            puts "Username already exists."
            self.create_account
        else 
            #prompt = TTY::Prompt.new
            password = $prompt.mask("Please create a password:")
            if password == $prompt.mask("Please re-enter password:")
                User.create({username: username, password: password, signed_in?: true})
                puts "Account username: \"#{username}\" created! You are now signed in!"
                sleep (2)
                welcome 
            else 
                puts "Passwords did not match, please try again."
                sleep (2)
                self.create_account
            end
        end 
    end

    def self.is_signed_in
        User.which_user ?
        true : false
    end

    def self.which_user
        User.find_by(signed_in?: true)
    end

end