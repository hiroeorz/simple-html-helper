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

  def to_short(name_length = 20, continue_string = "...")
    if self.jlength <= name_length
      return self.dup
    end

    new_string = ""

    self.each_char do |c|
      new_string << c

      break if new_string.jlength >= name_length
    end

    return new_string << continue_string
  end

  def to_under_score
    self.
      gsub(/^[A-Z]+/) {|e| e.downcase}.
      gsub(/[a-z][A-Z]+/) {|e| e[0, 1] + "_" + e[1..-1].downcase}
  end

end

class NilClass

  def to_html
    return ""
  end

end
