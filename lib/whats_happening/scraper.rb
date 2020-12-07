class WhatsHappening::Scraper

    def self.scrape_months
        doc = Nokogiri::HTML(open("https://nationaltoday.com/national-day-calendar/"))
        months = doc.css("div.daycal-month")

        months.each do |month|
            name = month.css("h2.daycal-month-name").text
            link = month.css("div.daycal-month-link a").attribute("href").value
            WhatsHappening::Month.new(name, link)
        end
    end

    def self.scrape_celebration(month)
        url = month.link
        doc = Nokogiri::HTML(open(url))

        celebrations = doc.css("tr.row-data.row-months")

        celebrations.each do |celebration|
            name = celebration.css("td.title").text
            category = celebration.css("td.category").text
            link = celebration.css("td.title a").attribute("href").value
            WhatsHappening::Celebration.new(name, month, category, link)
        end
    end
 
    def self.scrape_info(celebration)
        url = celebration.link
        doc = Nokogiri::HTML(open(url))
        descriptions = doc.css("div.holiday-section.holiday-content")

        descriptions.each do |description|
            info = description.css("div.entry-content-inner p").text
            celebration.description << info
        end
    end

    # def scrape_today
    #     url = "https://nationaltoday.com/"
    #     doc = Nokogiri::HTML(open(url))
    #     todays_holiday = doc.css("div.slider-day-content")
    #     todays_holiday.each do |holiday|
    #         name = holiday.css("h2.holiday-title-text").text
    #         link = holiday.css("a").attr("href")
    #     end
    # end
            
    
end

