class Builders::AirtableData < SiteBuilder
  def build
    puts config["airtable_api_key"]
    url = "https://api.airtable.com/v0/app5RG1gIK9buK1iC/events?api_key=#{config["airtable_api_key"]}"
    # get , headers: {"Authorization" => "Bearer #{config["airtable_api_key"]}"} do |data|
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
end
