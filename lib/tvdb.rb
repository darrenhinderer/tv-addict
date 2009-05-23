require 'net/http'
require 'uri'
require 'rexml/document'
require 'date'

module TVDB

  SERIES_URL = "http://www.thetvdb.com/api/GetSeries.php?seriesname="

  def self.search(val)
    search_str = SERIES_URL + URI.escape(val)
    xml = REXML::Document.new(Net::HTTP.get(URI.parse(search_str)))
  
    series_list = []
    xml.each_element("//Series")  do |series_xml|
      series = Series.new
      series.id = series_xml.text("id")
      series.name = series_xml.text("SeriesName")
      series.series_id = series_xml.text("seriesid")
      series.overview = series_xml.text("Overview")
      series.safe_first_aired = series_xml.text("FirstAired")
      series.safe_banner = series_xml.text("banner")
      series.safe_imdb = series_xml.text("IMDB_ID")
      series_list << series
    end

    series_list
  end

  def self.download_image(filename)
    image_url = "http://thetvdb.com/banners/#{filename}"
    uri = URI.parse(image_url)
    path = "public/images#{uri.path}"
    unless File.exists?(path)
      open(path, "wb") do |file|
        file.write(Net::HTTP.get(uri))
      end
    end
  end

  class REXML::Element
    def text(val)
      if get_text(val)
        get_text(val).value
      else
        nil
      end
    end
  end

  class Series
    attr_accessor :id, :series_id, :name, :overview, 
                  :first_aired, :banner, :imdb

    def safe_banner=(val)
      if val
        self.banner = "banners/#{val}"
        TVDB.download_image(val)
      end
    end

    def safe_first_aired=(val)
      if val
        self.first_aired = Date.strptime(val, "%Y-%m-%d")
      end
    end

    def safe_imdb=(val)
      if val
        self.imdb = "http://www.imdb.com/title/#{val}/"
      end
    end
  end

end
