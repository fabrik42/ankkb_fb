module Text

  def linkify(text)
    generic_URL = Regexp.new('(^|[\n ])([\w]+?://[\w]+[^ \"\n\r\t<]*)', Regexp::MULTILINE | Regexp::IGNORECASE)
    starts_with_www = Regexp.new('(^|[\n ])((www)\.[^ \"\t\n\r<]*)', Regexp::MULTILINE | Regexp::IGNORECASE)
    text.to_s.dup.gsub!(generic_URL, '\1<a href="\2">\2</a>').gsub!(starts_with_www, '\1<a href="http://\2">\2</a>')
  end

end