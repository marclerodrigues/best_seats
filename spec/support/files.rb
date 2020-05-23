def import_json_fixture(relative_file_path)
  directory = File.dirname(__FILE__)
  file_path = File.join(directory, relative_file_path)
  file = File.read(file_path)
  JSON.parse(file)
end
