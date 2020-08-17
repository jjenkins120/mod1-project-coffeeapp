class Order < ActiveRecord::Base
    belongs_to :user
    belongs_to :drink


    def new_order
    #     prompt = TTY::Prompt.new
    #    prompt.select("Please choose from one of the following options:") do |menu|
    #      menu.choice "Order", -> { "Order" }
    #      menu.choice "Sign In", -> { User.sign_in }
    #      menu.choice "Create Account", -> { User.create_account }
    #      menu.choice "Exit", -> { exit }
    #    end 
    end



end