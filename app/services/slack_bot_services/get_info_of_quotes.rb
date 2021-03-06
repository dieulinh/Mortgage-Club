require "quotes_formulas"

module SlackBotServices
  #
  # Class GetInfoOfQuotes provides quotes's info for Slack bot.
  #
  #
  class GetInfoOfQuotes
    extend ActionView::Helpers::NumberHelper
    extend QuotesFormulas

    PRODUCT = {
      "30yearFixed" => "30 year fixed",
      "15yearFixed" => "15 year fixed",
      "5yearARM" => "5/1 ARM"
    }

    def self.call(params)
      # host_name = ENV.fetch("HOST_NAME", "localhost:4000")
      output = "We're sorry, there aren't any quotes matching your needs."
      service = LoanTekServices::GetQuotesForSlackBot.new(params)

      if service.call
        quote_query = QuoteQuery.new(query: service.query_content)

        if quote_query.save
          output = "#{summary(service.quotes)} Do you want to apply for a mortgage now? (Yes/No)"
        end
      end

      output
    end

    #
    # It generates a summary which is sent to Slackbot.
    #
    # @param [Array] quotes List quotes we get from LoanTek.
    #
    # @return [String] a string containning a summary.
    #
    def self.summary(quotes)
      return if quotes.nil?
      quotes = get_valid_quotes(quotes)
      return if quotes.empty?

      summary = "Good news, I've found mortgage loans for you. Lowest rates as of today: \n"

      ["30yearFixed", "15yearFixed", "5yearARM"].each do |type|
        programs = quotes.select { |p| p["ProductName"] == type }
        next if programs.empty?

        lowest_program = programs.first
        programs.each { |p| lowest_program = p if lowest_program["APR"] > p["APR"] }
        min_apr = format("%0.03f", get_apr(lowest_program) * 100)
        lender_credit = number_to_currency(get_lender_credits(lowest_program).abs.to_i, precision: 0)
        fees = "$0 origination fee"

        summary += "#{PRODUCT[type]}: #{min_apr}% rate, #{fees}, #{lender_credit} lender credit\n"
      end

      summary
    end
  end
end
