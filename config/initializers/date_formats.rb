CUSTOM_DATETIME_FORMATS = {
  :short_date                 => "%b %d, %Y",
  :short_date_without_comma   => "%b %d %Y",
  :month_and_day_only         => "%B %d",
  :day_and_date_only          => "%a, %b %d",
  :short_with_time            => '%b %d, %Y %l:%M %p',
  :standard_time              => "%l:%M %p",
  :short_with_time_no_year    => '%b %d %l:%M %p',
  :short_with_time_no_year2   => '%m/%d %l:%M %p',
  :slash_separated_date       => '%m/%d/%y',
  :slash_separated_with_time  => '%m/%d/%y %l:%M %p'
}

[ Date::DATE_FORMATS,
  Time::DATE_FORMATS
].each do |h|
  h.merge!(CUSTOM_DATETIME_FORMATS)
end
