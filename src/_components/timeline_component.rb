class TimelineComponent < Bridgetown::Component
  def initialize(items:)
    @items = items

    split_by_date
  end

  def split_by_date
    @items_by_date = {}
    @items.each do |item|
      date_str = item.data.fields["start"]
      date = Date.parse(date_str)
      @items_by_date[date.year] = {} if @items_by_date[date.year].blank?
      @items_by_date[date.year][date.month] = [] if @items_by_date[date.year][date.month].blank?
      @items_by_date[date.year][date.month].append(item)
    end
  end
end
