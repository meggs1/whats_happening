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
            link = celebration.css("td.title a").attribute("href").value
            WhatsHappening::Celebration.new(name, month, link)
        end
    end

    def self.scrape_info(celebration)
        url = celebration.link
        doc = Nokogiri::HTML(open(url))

        doc.css("div.holiday-section.holiday-content p").each do |info|
            description = info.text.strip
            celebration.description << description
        end

        doc.css("ol.holiday-list.holiday-list-celebrate div.holiday-list-item-inner").each do |info|
            celebration.activity_title = info.css("h3").text
            celebration.activity_info = info.css("p").text
        end

        doc.css("section.holiday-history.holiday-section p").each do |info|
            history = info.text
            celebration.history << history
        end
    end
end

