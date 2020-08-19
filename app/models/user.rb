class User < ActiveRecord::Base
    has_many :orders
    has_many :drinks, through: :orders

    #Helper method that allows user to enter password while signing in
    def enter_password
        password = $prompt.mask("Please enter password:")
        if password == self.password 
            self.update(signed_in?: true)
            puts "You are signed in!"
            sleep (2)
            welcome
        else
            puts "Password incorrect"
            sign_in
        end
    end

end