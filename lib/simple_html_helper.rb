begin
  require "rubygems"
rescue LoadError
end


require "sanitize"

class String
  @@html_replace_target = {
    "<" => "&lt;",
    ">" => "&gt;",
    "\s" => "&nbsp;",
    "\"" => "&quot;",
  }

  @@sanitize_config = Sanitize::Config::RELAXED.
    merge({:add_attributes => {"a" => {"target" => "_blank"}}})

  @@use_sanitize = true


  def String.use_sanitize=(value)
    if !value.instance_of?(TrueClass) and !value.instance_of?(FalseClass)
      raise ArgumentError.new("invalid argument. set true or false")
    end
    
    @@use_sanitize = value
  end
  
  def String.use_sanitize
    @@use_sanitize
  end
  
  def String.sanitize_config=(value)
    @@sanitize_config = value
  end
  
  def String.sanitize_config
    @@sanitize_config
  end
  
  def String.html_replace_target=(value)
    @@html_replace_target = value
  end
  
  def String.html_replace_target
    @@html_replace_target
  end
  
  def sanitize(sanitize_config = @@sanitize_config)
    unless @@use_sanitize
      return self.dup
    end
    
    Sanitize.clean(self, sanitize_config)
  end
  
  def to_html
    self.
      to_html_amp.
      to_html_special_char.
      to_html_br.
      to_html_link.
      sanitize
  end

  def to_html_link(target = "_blank")
    self.gsub(/(https?\:[\w\.\~\-\/\?\&\+\=\:\@\%\;\#\%]+)/) {
      "<a href=\"#{$1}\" target=\"#{target}\">#{$1}</a>"
    }
  end

  def to_html_special_char
    text = self.dup

    @@html_replace_target.each do |key, value|
      text.gsub!(/#{key}/, value)
    end

    text
  end

  def to_html_amp
    self.gsub(/\&/, "&amp;")
  end

  def to_html_br
    self.
      gsub(/\r\n?/, "\n").
      gsub(/\r/, "\n").
      gsub(/\n/, "<br />")
  end

end
