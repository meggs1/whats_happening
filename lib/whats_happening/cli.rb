class WhatsHappening::CLI 

    def call
        puts "
        █▀▀▀▀▀▀▀▀▀▀▀▀▀▀▀▀▀▀▀▀█
        █░░╦─╦╔╗╦─╔╗╔╗╔╦╗╔╗░░█
        █░░║║║╠─║─║─║║║║║╠─░░█
        █░░╚╩╝╚╝╚╝╚╝╚╝╩─╩╚╝░░█
        ▀▀▀▀▀▀▀▀▀▀▀▀▀▀▀▀▀▀▀▀▀▀ ".yellow

        start
    end

    def get_months
        @months = WhatsHappening::Month.all
    end

    def start
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

    def list_months
        puts "Please enter the number of the month you're interested in:".green
        @months.each.with_index(1)  {|month, i| puts "#{i}. #{month.name}"}
    end
    
    def show_celebrations(input)
        month = @months[input - 1]
        month.get_celebrations
        if input > 0 && input <= month.celebrations.length
            puts "Here is what's happening in #{month.name}".light_magenta
            month.celebrations.each.with_index(1) do |celebration, i|
                puts "#{i}. #{celebration.name}"
            end
            get_user_celebration(month)
        else
            invalid_input
        end
    end

    def get_user_celebration(month)
        puts "Choose the number of an event to learn more or type 'list months' to list months".green
        input = gets.strip.to_i
        celebration = month.celebrations[input - 1]
        celebration.get_celebration_description
        if input > 0 && input < @months.length + 1
            show_celebration_descripton(celebration)
        elsif input == "list_months"
            list_months
        else
            invalid_entry
            get_user_celebration(month)
        end
    end

    def show_celebration_descripton(celebration)
        puts celebration.name.light_magenta
        puts celebration.description
        
        get_celebration_description(celebration)
    end

    def get_celebration_description(celebration)
        puts "type 'woo!' to see how you can participate, enter 'list months' to list months or type 'exit' to exit.".green
        input = gets.strip.downcase 
        if input == "woo!" || input == "woo"
            show_activity_title(celebration)
        elsif input == "list months"
            start
        elsif input == "exit"
            goodbye
        else
            invalid_entry
            get_celebration_description(celebration)
        end
    end

    def show_activity_title(celebration)
        puts "To celebrate #{celebration.name} you can #{celebration.activity_title.downcase}!"
        get_activity_title(celebration)
    end

    def get_activity_title(celebration)
        puts "to learn more enter 'learn more', to list months enter 'list months'  or type 'exit' to exit.".green
        input = gets.strip.downcase
        if input == "learn more"
            show_activity_info(celebration)
        elsif input == "list months"
            start
        elsif input == "exit"
            goodbye
        else
            invalid_entry
            get_activity_title(celebration)
        end
    end

    def show_activity_info(celebration)
        puts celebration.activity_info
        get_activity_info(celebration)
    end

    def get_activity_info(celebration)
        puts "to list months enter 'list months'  or type 'exit' to exit.".green
        input = gets.strip.downcase
        if input == "list months"
            start
        elsif input == "exit"
            goodbye
        else
            invalid_entry
            get_activity_info(celebration)
        end
    end

    def invalid_entry
       puts  "Sorry, not sure what you mean. Try again".red
       puts " "
    end

    def goodbye
        puts "Goodbye! See you next month!".yellow
    end
end

