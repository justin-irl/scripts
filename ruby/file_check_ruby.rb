# check files for matching type and sub text based on regex matching

def file_checker
  Dir.glob('*.md').each do |file|
    file = File.read(file)

    first_update = file.gsub(/REGEX_HERE/, 'REPLACEMENT_TEXT_HERE')
    second_update = first_update.gsub(/REGEX_HERE/, 'REPLACEMENT_TEXT_HERE')

    File.open(file, 'w') do |f|
      f.write(second_update)
    end 
  end
end

file_checker