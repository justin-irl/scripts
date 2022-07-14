# check files for yaml fromt matter and update accordlingly
require 'yaml'

def file_checker_yaml
  id = nil
  value = nil
  Dir.glob('*.md').each do |file|
    file = File.read(file)

    if file.match(/^---/)
      yaml_file = YAML.load(file)

      file.each do |k, v|
        case k
        when 'id'
          id = v
        when 'title'
          title = v
        end

        # updates id and title
        id = id.sub(/[\/\\\s\.,-@\*\&]/, '_')
        title = title.capitalize

        first_update = file.gsub(/ID_REGEX_HERE/, "id: #{id}")
        second_update = first_update.gsub(/TITLE_REGEX_HERE/, "title: #{title}")

        File.open(file, 'w') do |f|
          f.write(second_update)
        end
      else
        puts "Not a YAML file"
      end
    end
  end


file_checker_yaml



File.open(file, 'w') do |f|
  f.write(second_update)
end