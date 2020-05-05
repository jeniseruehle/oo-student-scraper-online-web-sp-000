require 'open-uri'
require 'pry'

class Scraper

  def self.scrape_index_page(index_url)
    students = []
    index = Nokogiri::HTML(open(index_url))
    index.css("div.student-card").each do |student|
      student_info = {
        name: student.css(".student-name").text, 
        location: student.css(".student-location").text,
        profile_url: student.css("a").attribute("href").value
      }
      students << student_info
    end
    students   
  end

  def self.scrape_profile_page(profile_url)
    student = {}
    index = Nokogiri::HTML(open(profile_url))
    container = index.css(".social-icon-container a").collect{|icon| icon.attribute("href").value}
      url = student.attribute("href")
      students[:twitter_url] = url if url.include?("twitter")
      students[:linkedin_url] = url if url.include?("linkedin")
      students[:github_url] = url if url.include?("github")
      students[:blog_url] = url if student.css("img").attribute("src").text.include?("rss")
    end
      students[:profile_quote] = html.css("div.profile-quote").text
      students[:bio] = html.css("div.bio-content p").text
    students
  end
end 
