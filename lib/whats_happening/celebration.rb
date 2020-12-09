class WhatsHappening::Celebration
    attr_accessor :name, :month, :link, :description, :activity_title, :activity_info, :history
    @@all = []
    
    def initialize(name, month, link)
        @name = name
        @month = month
        @link = link
        @description = []
        @activity_title = activity_title
        @activity_info = activity_info
        @history = []
        add_to_month
        @@all << self
    end
    
    def self.all
        @@all
    end
    
    def add_to_month
        @month.celebrations << self unless @month.celebrations.include?(self)
    end
    
    def get_celebration_description
        WhatsHappening::Scraper.scrape_info(self) if @description.empty?
    end

    def get_celebration_history
        WhatsHappening::Scraper.scrape_info(self) if @history.empty?
    end

end
