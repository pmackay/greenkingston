class Builders::AirtableData < SiteBuilder
  def build
    puts config["airtable_api_key"]
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
        fields["content"] = fields["title"]
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
        fields["content"] = "#{fields["name"]} began"
        fields["group"] = 1 # local
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
