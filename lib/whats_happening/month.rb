class WhatsHappening::Month
    attr_accessor :name, :link, :celebrations
    @@all = []
    
    def initialize(name, link)
        @name = name
        @link = link
        @celebrations = []
        save
    end

    def self.all
        WhatsHappening::Scraper.scrape_months if @@all.empty?
        @@all
    end
    
    def get_celebrations
        WhatsHappening::Scraper.scrape_celebration(self) if @celebrations.empty?
    end

    def save
        @@all << self
    end

end

