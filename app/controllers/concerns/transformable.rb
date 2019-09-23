module Concerns::Transformable
  extend ActiveSupport::Concern

  def response_to_quote(quotes,search)
    quotes.each do |item|
      item = item.stringify_keys
      quote= Quote.new
      quote.value = item['value']
      quote.cn_id = item['id']
      quote.search_id = search.id
      quote.save
    end
  end

  def quote_to_response(search)
    all_quotes = Quote.where("search_id = #{search.id}").pluck(:id,:value)
    quotes = []
    all_quotes.each do |quote|
      opt = {}
      opt['id'] = quote.first
      opt['value'] = quote.last
      quotes.append(opt)
    end
    quotes
  end

  private

end