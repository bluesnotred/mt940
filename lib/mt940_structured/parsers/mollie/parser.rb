module MT940Structured::Parsers::Mollie
  class Parser < MT940Structured::Parsers::Base
    def initialize
      super "Mollie", TransactionParsers.new
    end
  end

  class TransactionParsers

    def for_format(_)
      TransactionParser.new
    end
  end

end
