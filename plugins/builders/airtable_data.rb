require 'kramdown'

class Builders::AirtableData < SiteBuilder
  def build
    build_events
    build_entities
  end

  private

  def build_events
    url = base_url("events")
    get url do |data|
      data["records"].each do |event|
        # puts event.to_s
        fields = event["fields"]
        fields["start"] = fields["startDate"]
        fields["content"] = Kramdown::Document.new(fields["title"]).to_html[3..-3]
        fields["group"] = fields["group"] == "local" ? 1 : 2
        add_resource :events, "#{event["id"]}" do
          fields fields
          title fields["title"]
          id event["id"]
        end
      end
    end
  end

  def build_entities
    url = base_url("entities")
    get url do |data|
      data["records"].each do |event|
        # puts event.to_s
        fields = event["fields"]
        fields["start"] = fields["startDate"]
        fields["group"] = 1 # local
        # puts fields["image"]
        # puts fields["image"].class
        # fields["image"] = JSON.parse(fields["image"][0])
        # fields["image"] = fields["image"][0]
        # puts fields["image"]
        # puts fields["image"]["thumbnails"]
        # puts fields["image"]["thumbnails"]["small"]
        # puts fields["image"]["thumbnails"]["small"]["url"]
        fields["content"] = fields["url"] ? "<a href=\"#{fields["url"]}\">#{fields["name"]}</a> began" : "#{fields["name"]} began"
        if fields["image"][0]
          fields["image_url"] = fields["image"][0]["thumbnails"]["small"]["url"]
          img_el = "<img src=\"#{fields["image_url"]}\"/>"
          # fields["content"] += CGI::escapeHTML(img_el)
        end
        fields["image"] = ''
        add_resource :events, "#{event["id"]}" do
          fields fields
          title fields["title"]
          id event["id"]
        end
      end
    end
  end

  def base_url(base_name)
    "https://api.airtable.com/v0/app5RG1gIK9buK1iC/#{base_name}?api_key=#{ENV["AIRTABLE_API_KEY"]}"
  end
end
