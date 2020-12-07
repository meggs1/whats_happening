class WhatsHappening::CLI 

    def call
        puts "Welcome to What's Happening!"
        menu
    end

    def get_months
        @months = WhatsHappening::Month.all
    end

    def list_months
        @months.each.with_index(1)  {|month, i| puts "#{i}. #{month.name}"}
    end

    def menu
        input = nil
        puts "Enter the number of the month you're interested in:"
        get_months
        list_months
        input = gets.strip.to_i
        if input > 0 && input < @months.length + 1
            show_celebrations(input)
        elsif input == "exit"
            goodbye
        else 
            invalid_entry
        end

        
    end




    # def get_user_month
    #     user_month = gets.strip.to_i
    #     show_celebrations(user_month) if valid_input(user_month, @months)
    # end

    # def valid_input(user_month, data)
    #     input.to_i <= data.length && input.to_i > 0
    # end

    def show_celebrations(input)
        month = @months[input - 1]
        month.get_celebrations
        puts "Here is what's happening in #{month.name}"
        month.celebrations.each.with_index(1) do |celebration, i|
            puts "#{i}. #{celebration.name}"
        end
        get_user_celebration(month)
    end

    def get_user_celebration(month)
        puts "Choose an event to learn more:"
        input = gets.strip
        celebration = month.celebrations[input.to_i - 1]
        celebration.get_celebration_description
        show_celebration_descripton(celebration)
    end

    def show_celebration_descripton(celebration)
        puts celebration.name
        celebration.description.each {|d| puts "#{d}"}
        show_activity(celebration)
    end

    def show_activity(celebration)
        celebration.activity.each {|activity| puts "#{activity}."}
    end

    def invalid_entry
       puts  "Sorry, not sure what you mean, try again"
       menu
    end

    def what_next
        puts "type'exit' to exit"
        @input = gets.strip
    end
    def goodbye
        puts "bye"
    end
end



# def menu
#     puts "Enter the number of the month you're interested in:"
#     list_months
#     get_user_month
#     show_celebrations(user_month)
# end


# def options
#     puts "Type 'learn more' to learn more, 'months' to list months or 'exit' to exit."
#     if input == "learn more"
#         puts "more info"
#     elsif input == "months"
#         list_months
#     elsif input == "exit"
#         exit
#     else
#         "sorry invalid"
#     end
# end