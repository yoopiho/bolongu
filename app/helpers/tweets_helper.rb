module TweetsHelper  

  def tweet_body(text)
    linkup_mentions(auto_link(text))
  end

  def linkup_mentions(text)    
    text.gsub!(/@([\w]+)(\W)?/, '@<a href="/twitter/\1">\1</a>\2')
    text
  end
  
  def pretty_datetime(datetime)
    date = datetime.strftime('%b %e, %Y').downcase
    time = datetime.strftime('%l:%M%p').downcase
    content_tag(:span, date, :class => 'date') + " " + content_tag(:span, time, :class => 'time')
  end
end
