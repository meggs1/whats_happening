class WhatsHappening::CLI 

    def call
        puts "
        █▀▀▀▀▀▀▀▀▀▀▀▀▀▀▀▀▀▀▀▀█
        █░░╦─╦╔╗╦─╔╗╔╗╔╦╗╔╗░░█
        █░░║║║╠─║─║─║║║║║╠─░░█
        █░░╚╩╝╚╝╚╝╚╝╚╝╩─╩╚╝░░█
        ▀▀▀▀▀▀▀▀▀▀▀▀▀▀▀▀▀▀▀▀▀▀ "

        start
    end

    def get_months
        @months = WhatsHappening::Month.all
    end

    def list_months
        puts "Enter the number of the month you're interested in:"
        @months.each.with_index(1)  {|month, i| puts "#{i}. #{month.name}"}
    end

    def start
        input = nil
        get_months
        list_months
        input = gets.strip.to_i
        if input > 0 && input < @months.length + 1
            show_celebrations(input)
        elsif input == "exit"
            goodbye
        else 
            invalid_entry
            start
        end
    end
    
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
        input = gets.strip.to_i
        celebration = month.celebrations[input - 1]
        celebration.get_celebration_description
        if input > 0 && input < @months.length + 1
            show_celebration_descripton(celebration)
        else
            invalid_entry
            show_celebrations(input)
        end
    end

    def show_celebration_descripton(celebration)
        puts celebration.name
        puts " "
        puts celebration.description
        puts " "
        puts "type 'woo!' to see how you can celebrate, enter 'list months' to show months or type 'exit' to exit."
        input = gets.strip.downcase 
        if input == "woo!" || "woo"
            show_activity_title(celebration)
        elsif input == "list months"
            list_months
        elsif input == "exit"
            goodbye
        else
            invalid_entry
            show_celebration_descripton(celebration)
        end
    end

    def show_activity_title(celebration)
        puts "To celebrate #{celebration.name} you can #{celebration.activity_title.downcase}!"
        puts " "
        puts "to learn more enter 'learn more',  to list months enter 'list months'  or type 'exit' to exit."
        input = gets.strip.downcase
        if input == "learn more"
            show_activity_info(celebration)
        elsif input == "list months"
            list_months
        elsif input == "exit"
            goodbye
        else
            invalid_entry
            show_activity_title(celebration)
        end
    end

    def show_activity_info(celebration)
        puts " "
        puts celebration.activity_info
        
        puts "to list months enter 'list months'  or type 'exit' to exit."
        input = gets.strip.downcase
        if input == "list months"
            list_months
        elsif input == "exit"
            goodbye
        else
            invalid_entry
            show_activity_info(celebration)
        end
    end

    def invalid_entry
       puts  "Sorry, not sure what you mean, try again"
       puts " "
    end

    def goodbye
        puts "See you next month!"
    end
end

