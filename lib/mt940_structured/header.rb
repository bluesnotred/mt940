module MT940Structured
  class Header
    R_RABOBANK = /^:940:/
    R_ABN_AMRO = /ABNANL/
    R_TRIODOS = /^:25:TRIODOSBANK|^:25:NL\d{2}TRIO/
    R_ING = /INGBNL/
    R_DEUTSCHE_BANK = /:20:DEUTDE/
    R_KNAB = /KNABNL/
    R_VAN_LANSCHOT = /FVLBNL/
    R_SNS = /SNSBNL/
    R_ASN = /ASNBNL/
    R_REGIO_BANK = /RBRBNL/
    R_MONEYOU = /MOYONL21/
    R_MOLLIE = /:25:NL30ABNA0524590958/

    def initialize(raw_lines)
      @raw_lines = raw_lines
    end

    def parser
      if @raw_lines[0].match(R_RABOBANK)
        MT940Structured::Parsers::Rabobank::Parser.new
      elsif @raw_lines[0].match(R_ABN_AMRO)
        MT940Structured::Parsers::Abnamro::Parser.new
      elsif @raw_lines[0].match(R_MONEYOU)
        MT940Structured::Parsers::Abnamro::Parser.new("Moneyou")
      elsif @raw_lines[1] && @raw_lines[1].match(R_TRIODOS)
        MT940Structured::Parsers::Triodos::Parser.new
      elsif @raw_lines[0].match(R_ING)
        MT940Structured::Parsers::Ing::Parser.new
      elsif @raw_lines[0].match(R_DEUTSCHE_BANK)
         MT940Structured::Parsers::DeutscheBank::Parser.new
      elsif @raw_lines[0].match(R_KNAB)
        MT940Structured::Parsers::Knab::Parser.new
      elsif @raw_lines[0].match(R_VAN_LANSCHOT)
        MT940Structured::Parsers::VanLanschot::Parser.new
      elsif @raw_lines[0].match(R_SNS) || @raw_lines[0].match(R_ASN) || @raw_lines[0].match(R_REGIO_BANK)
        MT940Structured::Parsers::Sns::Parser.new
      elsif @raw_lines[1] && @raw_lines[1].match(R_MOLLIE)
        MT940Structured::Parsers::Mollie::Parser.new
      else  
        raise UnsupportedBankError.new
      end
    end

  end
  class UnsupportedBankError < StandardError

  end
end
