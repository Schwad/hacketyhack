# Hpricot shim for running Hackety Hack on modern Ruby/Scarpe
# Hpricot was _why's HTML parser; it's used by HH's web features
# (Feed parsing, RSS, hackety-hack.com API) which are all dead.
# This shim provides just enough structure to let the app boot.
#
# Also stubs out the dead web API so HH doesn't try to connect.

module Hpricot
  class Doc
    def initialize(html = "")
      @html = html
    end

    def at(selector)
      nil
    end

    def /(selector)
      []
    end

    def widget(slot)
      # no-op
    end

    def to_s
      @html.to_s
    end

    def length
      to_s.length
    end
  end

  module Traverse
    def build_list(ary, top = ary, inside = false) end
  end

  class Elem
    include Traverse
    def initialize(name = "", attrs = {})
      @name = name
      @attrs = attrs
    end

    def name; @name; end

    def [](key)
      @attrs[key]
    end

    def inner_text
      ""
    end
  end

  class Text
    include Traverse
    def inner_text
      ""
    end
  end

  def self.parse(html)
    Doc.new(html)
  end

  def self.XML(data)
    Doc.new(data)
  end
end

# Make Hpricot() callable as a method
def Hpricot(html)
  Hpricot::Doc.new(html)
end
