module Text

  def linkify(text)
    generic_URL = Regexp.new('(^|[\n ])([\w]+?://[\w]+[^ \"\n\r\t<]*)', Regexp::MULTILINE | Regexp::IGNORECASE)
    starts_with_www = Regexp.new('(^|[\n ])((www)\.[^ \"\t\n\r<]*)', Regexp::MULTILINE | Regexp::IGNORECASE)
    text.to_s.dup.gsub!(generic_URL, '\1<a href="\2">\2</a>').gsub!(starts_with_www, '\1<a href="http://\2">\2</a>')
  end

  def simple_format(text, options = {})
    options.reverse_merge({
      :class => ""
    })
    start_tag = "<p class=\"#{options[:class]}\">"
    
    text = '' if text.nil?
    text = text.dup.to_str
    text.gsub!(/\r\n?/, "\n")                    # \r\n and \r -> \n
    text.gsub!(/\n\n+/, "</p>\n\n#{start_tag}")  # 2+ newline  -> paragraph
    text.gsub!(/([^\n]\n)(?=[^\n])/, '\1<br />') # 1 newline   -> br
    text.insert 0, start_tag
    text << "</p>"
  end

  def nl2br(text)
    text = '' if text.nil?
    text = text.dup.to_str
    text.gsub!(/\r\n?/, "\n")                    # \r\n and \r -> \n
    text.gsub!(/([^\n]\n)(?=[^\n])/, '\1<br />') # 1 newline   -> br
  end

end