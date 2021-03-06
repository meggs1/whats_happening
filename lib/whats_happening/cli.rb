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

    def start
        get_months
        list_months
        input = gets.strip.to_i
        if input > 0 && input < @months.length + 1
            list_celebrations(input)
        elsif input == "exit"
            goodbye
        else 
            invalid_entry
            start
        end
    end

    def get_months
        @months = WhatsHappening::Month.all
    end

    def list_months
        puts "Please enter the number of the month you're interested in:".green
        @months.each.with_index(1)  {|month, i| puts "#{i}. #{month.name}"}
    end
    
    def list_celebrations(input)
        month = @months[input - 1]
        month.get_celebrations
        if input > 0 && input <= @months.length
            puts "Here is what's happening in #{month.name}:".light_magenta
            month.celebrations.each.with_index(1) do |celebration, i|
                puts "#{i}. #{celebration.name}"
                sleep 0.1
            end
            get_user_celebration(month)
        else
            invalid_entry
        end
    end

    def get_user_celebration(month)
        puts "Choose the number of an event to learn more:".green
        input = gets.strip.to_i
        celebration = month.celebrations[input - 1]
        if input > 0 && input < month.celebrations.length + 1
            celebration.get_celebration_info
            celebration_menu(celebration)
        else
            invalid_entry
            get_user_celebration(month)
        end
    end

    def celebration_menu(celebration)
        puts " "
        puts "Enter 'd' to show #{celebration.name}'s description, 'h' for the history, 'a' for an activity.".cyan
        puts "To go back to the list of months enter 'm', or 'exit' to exit.".cyan
        input = gets.strip.downcase

        if input == "d"
            show_celebration_descripton(celebration)
        elsif input == "h"
            show_celebration_history(celebration)
        elsif input == "a"
            show_activity(celebration)
        elsif input == "m"
            start
        elsif input == "exit"
            goodbye
        else 
            invalid_entry
            celebration_menu(celebration)
        end
    end

    def show_celebration_descripton(celebration)
        celebration.description.each {|d| puts "\n#{d}"}
        celebration_menu(celebration)
    end

    def show_celebration_history(celebration)
        if celebration.history.empty?
            puts "Sorry, no information on that.".red
        else
            puts " "
            puts "The history of #{celebration.name}".light_magenta
            celebration.history.each {|h| puts "\n#{h}"}
        end
        celebration_menu(celebration)
    end

    def show_activity(celebration)
        if celebration.activity_title.empty?
            puts "Sorry, no information on that.".red
        else
            puts " "
            puts "To participate in #{celebration.name} you can #{celebration.activity_title.downcase}!".light_magenta
            puts "#{celebration.activity_info}"
        end
        celebration_menu(celebration)
    end

    def invalid_entry
       puts " "
       puts "Not sure what you mean. Try again".red
    end

    def goodbye
        puts "Goodbye! See you next month!".yellow
    end
end