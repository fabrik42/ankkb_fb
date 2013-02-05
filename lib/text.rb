# encoding: UTF-8
module Text

  def site_keywords(keywords)
    keywords = [] if keywords.nil?

    default_keywords = [
      "ankkb",
      "Hergershausen",
      "Kerbborsche",
      "Hergershäuser Kerb",
      "Postleitzahl: 64832",
      "Babenhausen (Hessen)",
      "Vorwahl: 06073"
    ]

    (keywords + default_keywords)[0...10].join ", "
  end

  def site_title(title = nil)
    postfix = "ANKKB Hergershausen"
    if title
      "#{truncate(title, 50)} - #{postfix}"
    else
      postfix
    end
  end

  def site_description(description)
    truncate(description, 156).gsub(/<\/?[^>]*>/, "")
  end

  def d(date, format)
    I18n.l(date, :format => format)
  end

  def truncate(text, length)
    omission = "..."
    text = text.dup
    return text if text.size < length
    text[0...(length-omission.length)] + omission
  end

  def linkify(text)
    text = text.to_s.dup
    generic_URL = Regexp.new('(^|[\n ])([\w]+?://[\w]+[^ \"\n\r\t<]*)', Regexp::MULTILINE | Regexp::IGNORECASE)
    starts_with_www = Regexp.new('(^|[\n ])((www)\.[^ \"\t\n\r<]*)', Regexp::MULTILINE | Regexp::IGNORECASE)
    text.gsub!(generic_URL, '\1<a href="\2">\2</a>')
    text.gsub!(starts_with_www, '\1<a href="http://\2">\2</a>')
    text
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
    text
  end

end