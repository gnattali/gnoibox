base_url = "http://#{request.host_with_port}"
xml.instruct! :xml, :version=>'1.0'
xml.tag! 'urlset', 'xmlns' => 'http://www.sitemaps.org/schemas/sitemap/0.9' do
  xml.url{
      xml.loc(base_url+"/")
      xml.changefreq("daily")
      xml.priority(1.0)
  }
    @items.each do |item|
      xml.url {
        xml.loc "#{base_url + item.link_url}"
        xml.lastmod item.updated_at.strftime("%F")
        xml.changefreq("weekly")
        xml.priority(0.5)
      }
    end
end
