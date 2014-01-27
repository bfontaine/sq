# -*- coding: UTF-8 -*-

require 'fakeweb'

FakeWeb.allow_net_connect = false

#Dir["#{RESPONSES_DIR}/*.json"].each do |f|
#  next if f !~ /\/(\w+)\.json$/
#  term = $1
#  puts "registering fake response for #{term}."
#  FakeWeb.register_uri(
#    :get,
#    "#{BASE_URL}?term=#{term}",
#    :body => File.read(f)
#  )
#end

def html(b)
  <<-EOHTML
    <!doctype html>
    <html lang="en" dir="ltr">
      <head>
        <meta charset="utf-8" />
        <meta name="language" content="en" />
        <title>Foo</title>
      </head>
      <body>#{b}</body>
    </html>
  EOHTML
end

BASE_URL = 'example.com'
HTTP_URL = "http://#{BASE_URL}"

## simple queries ##

FakeWeb.register_uri(
  :get,
  "#{BASE_URL}/no-links",
  :body => html('<p>pdf 1, pdf 2, pdf 3</p>')
)

FakeWeb.register_uri(
  :get,
  "#{BASE_URL}/no-href",
  :body => html('<a>pdf 1</a><a>pdf 2</a><a>pdf 3</a>')
)

FakeWeb.register_uri(
  :get,
  "#{BASE_URL}/no-pdf",
  :body => html('<a href="foo.txt">pdf 1</a><a href="foo.jpg">pdf 2</a>')
)

FakeWeb.register_uri(
  :get,
  "#{BASE_URL}/bar",
  :body => html('<a href="bar1.pdf">pdf 1</a><a href="bar2.pdf">pdf 2</a>')
)

FakeWeb.register_uri(
  :get,
  "#{BASE_URL}/ab/so/lu/te",
  :body => html('<a href="/bar1.pdf">pdf 1</a>')
)

FakeWeb.register_uri(
  :get,
  "#{BASE_URL}/malformed1",
  :body => html('<p><a href="/bar1.pdf">pdf 1</p>')
)

FakeWeb.register_uri(
  :get,
  "#{BASE_URL}/malformed2",
  :body => html('<p><a href=bar1.pdf >pdf 1</a></p>')
)

FakeWeb.register_uri(
  :get,
  "#{BASE_URL}/malformed3",
  :body => html('<p><a foo="bar" HrEF="/bar1.pdf" >pdf 1</p>')
)

FakeWeb.register_uri(
  :get,
  "#{BASE_URL}/one",
  :body => html('<a href="/bar.pdf">pdf 1</a>')
)

## PDFs ##

FakeWeb.register_uri(
  :get,
  "#{BASE_URL}/bar.pdf",
  :body => '%PDFbar'
)

FakeWeb.register_uri(
  :get,
  "#{BASE_URL}/foo.pdf",
  :body => '%PDFfoo'
)
