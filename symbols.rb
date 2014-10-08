def super_print(string, options = {})
  default_options = {
    times: 1,
    upcase: false,
    reverse: false
  }
  
  options = default_options.merge(options)
  
  string.upcase! if options[:upcase]
  string.reverse! if options[:reverse]
  
  options[:times].times do
    puts string
  end
end