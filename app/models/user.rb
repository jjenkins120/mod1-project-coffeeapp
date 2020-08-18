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

    def enter_password
        puts "Please enter password"
        password = gets.chomp 
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
        puts "Please enter a username:"
        username = gets.chomp
        if self.find_by(username: username.downcase)
            puts "Username already exists."
            self.create_account
        else 
            puts "Please create a password"
            password = gets.chomp
            User.create({username: username, password: password, signed_in?: true})
            puts "Account username: \"#{username}\" created! You are now signed in!"
            sleep (2)
            welcome 
        end 
    end

    def self.is_signed_in
        User.find_by(signed_in?: true)?
        true : false
    end

end