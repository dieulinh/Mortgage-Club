class QuoteService

    def self.create_graph_quote(quote)
      @quote = quote
      @query = {}
      @query = JSON.parse(@quote.query) if @quote
      @quotes = LoanTekServices::GetInitialQuotes.new(@query).lowest_apr
      if @quotes
        year30 = @quotes["30 year fixed"].to_json
        year15 = @quotes["15 year fixed"].to_json
        arm71 = @quotes["7/1 ARM"].to_json
        arm51 = @quotes["5/1 ARM"].to_json
        graph = GraphQuoteQuery.new(year30: year30, year15: year15, arm71: arm71, arm51: arm51, quote_query_id: quote.id)
        graph.save!
      end
    end

    def self.update_graph_quote(quote)
      @quote = quote
      @query = JSON.parse(@quote.query)
      @trigger_quote = []
      @pre_graph = GraphQuoteQuery.where(quote_query_id: @quote.id).order("created_at DESC").first
      @quotes = LoanTekServices::GetInitialQuotes.new(@query).lowest_apr
      if @quotes
        year30 = @quotes["30 year fixed"].to_json
        year15 = @quotes["15 year fixed"].to_json
        arm71 = @quotes["7/1 ARM"].to_json
        arm51 = @quotes["5/1 ARM"].to_json
        g_updated = self.check_updating(@quotes, @pre_graph)
        new_graph = GraphQuoteQuery.new(year30: year30, year15: year15, arm71: arm71, arm51: arm51, quote_query_id: quote.id, g_updated: g_updated)
        new_graph.save!
      end
    end

    private
    def self.check_updating(new_quotes, pre_quotes)
      return true if check_updating_program(new_quotes["30 year fixed"], JSON.parse(pre_quotes.year30))
      return true if check_updating_program(new_quotes["15 year fixed"], JSON.parse(pre_quotes.year15))
      return true if check_updating_program(new_quotes["7/1 ARM"], JSON.parse(pre_quotes.arm71))
      return true if check_updating_program(new_quotes["5/1 ARM"], JSON.parse(pre_quotes.arm51))
      false
    end

    def self.check_updating_program(new_program, pre_program)
      rate = new_program[:interest_rate] == pre_program["interest_rate"]
      lender_credits = new_program[:lender_credits] == pre_program["lender_credits"]
      return true if !rate || !lender_credits
      false
    end
end
