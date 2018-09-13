require 'algoliasearch'
require 'dotenv'

Dotenv.load

Algolia.init(application_id: 'RJGB7SJIDM',
             api_key:        ENV['API_KEY'])
index = Algolia::Index.new('Docs_testing')

objects = [{
  hoi: 'hi',
  niethoi: 'niethoi'
}]

# index.add_objects(objects)

# sitemap.resources.each do |f|
#   if f.content_type.include? 'html'
#     puts f.path
#   end
# end

