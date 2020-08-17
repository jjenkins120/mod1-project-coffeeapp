class User < ActiveRecord::Base
    has_many :orders
    has_many :drinks, through: :orders

    def self.sign_in
        puts "Please enter username or type 'exit' to exit"
        username = gets.chomp
        if username == "exit"
            #[main menu option]
        else
            if user = User.all.find_by(username: username)
                user.enter_password
            else
                puts "User does not exist"
                #[method for going back]
            end
        end
    end

    def enter_password
        puts "Please enter password"
        password = gets.chomp 
        if password == self.password 
            self.update(signed_in?: true)
            puts "You are signed in!"
        else
            puts "Password incorrect"
            User.sign_in
        end
    end

end