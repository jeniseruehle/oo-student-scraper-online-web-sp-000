require 'open-uri'
require 'pry'

class Scraper

  def self.scrape_index_page(index_url)
    students = []
    html = Nokogiri::HTML(open(index_url))
    html.css(".student-card").collect do |student|
      student_info = {
        name: student.css("h4.student-name").text, 
        location: student.css("p.student-location").text,
        profile_url: "https://learn-co-curriculum.github.io/student-scraper-test-page/" + student.css("a").attribute("href")
      }
      students << student_info
    end
    students   
  end

  def self.scrape_profile_page(profile_url)
    students = {}
    html = Nokogiri::HTML(open(profile_url))
    html.css("div.social-icon-controler a").each do |student|
      url = student.attribute("href")
      students[:twitter_url] = url if url.include?("twitter")
      students[:linkedin_url] = url if url.include?("linkedin")
      students[:github_url] = url if url.include?("github")
      students[:blog_url] = url if student.css("img").attribute("src").text.include?("rss")
  end

end

