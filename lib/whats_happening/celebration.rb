class WhatsHappening::Celebration
    attr_accessor :name, :month, :link, :description, :activity_title, :activity_info, :history
    @@all = []
    
    def initialize(name, month, link)
        @name = name
        @month = month
        @link = link
        @activity_title = activity_title
        @activity_info = activity_info
        @description = []
        @history = []
        add_to_month
        save
    end
    
    def self.all
        @@all
    end
    
    def add_to_month
        @month.celebrations << self unless @month.celebrations.include?(self)
    end
    
    def get_celebration_info
        WhatsHappening::Scraper.scrape_info(self) if @description.empty?
    end

    def save
        @@all << self
    end
end
