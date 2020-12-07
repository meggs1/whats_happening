class WhatsHappening::Celebration
    attr_accessor :name, :month, :category, :link, :description
    @@all = []
    
    def initialize(name, month, category, link)
        @name = name
        @month = month
        @category = category
        @link = link
        @description = []
        add_to_month
        @@all << self
    end
    
    def self.all
        @@all
    end
    
    def add_to_month
        @month.celebrations << self unless @month.celebrations.include?(self)
    end
    
    def get_celebration_details
        WhatsHappening::Scraper.scrape_info(self) if @description.empty?
    end

end
