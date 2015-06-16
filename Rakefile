require_relative 'lib/constants'

task :internal_build do
  sh "bundle exec middleman build"
end

desc "Build site"
task :build => [:internal_build, "build/search/tipue-content.js"]

file "build/search/tipue-content.js" => "build/sitemap.xml" do
  require 'nokogiri'
  require 'stringio'
  require 'json'

  output = StringIO.new
  sitemap = Nokogiri.XML(File.open("build/sitemap.xml", "r"))
  each_sitemap_searchable_page(sitemap) do |page|
    index = page[:index]
    count = page[:count]
    doc   = page[:doc]

    content = extract_html_text_content(doc)

    if content
      output.write(JSON.generate(
        title: extract_title(doc),
        url: page[:url],
        tags: "",
        text: content
      ))

      if index == count - 1
        output.write("\n")
      else
        output.write(",\n")
      end
    else
      puts "  => Error! Cannot extract content!"
    end
  end

  puts "Writing build/search/tipue-content.js"
  File.open("build/search/tipue-content.js", "w") do |f|
    f.puts 'var tipuesearch = { "pages": ['
    f.write(output.string)
    f.puts '] };'
  end

  dummy_file = Dir["build/search/tipue-content-dummy-*.js"].first
  if dummy_file
    puts "Removing #{dummy_file}"
    File.unlink(dummy_file)
  end
end

file "build/sitemap.xml" do
  Rake::Task["internal_build"].invoke
end

desc "Upload documentation to server"
task :rsync => [:build] do
  sh "cd build && rsync -rv --progress --partial-dir=.rsync-partial --human-readable . " +
    "shell.phusion.nl:/home/phusion/websites/passenger_library/"
end


def each_sitemap_searchable_page(sitemap)
  elements = sitemap / "urlset/url"
  elements.each_with_index do |elem, i|
    path = build_file_path(elem)
    url  = build_search_index_url(elem)

    printf "[%d/%d] Indexing: %s\n", i, elements.size, path

    File.open(path, "r") do |f|
      doc = Nokogiri.HTML(f)
      if (doc / "head").to_s =~ /SKIP SEARCH/
        puts "  => Skipped"
      else
        yield(doc: doc, path: path, url: url, index: i, count: elements.size)
      end
    end
  end
end

def build_file_path(elem)
  loc = (elem / "loc").text
  result = loc.sub(/^#{Regexp.escape(URL_ROOT)}/, "build")
  if loc =~ %r(/$)
    result << "index.html"
  end
  result
end

def build_search_index_url(elem)
  loc = (elem / "loc").text
  loc.sub(/^#{Regexp.escape(URL_ROOT)}\//, "")
end

def extract_title(doc)
  result = (doc / "html/head/title").text
  result.sub(/ - #{Regexp.escape SITE_TITLE}$/, "")
end

def extract_html_text_content(doc)
  content_element = (doc / ".bs-docs-section").first
  if content_element
    content_element = content_element.dup
    h1 = (content_element / "h1:first-child").first
    h1.unlink if h1
    content_element.text.strip
  else
    nil
  end
end
