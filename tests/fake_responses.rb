# -*- coding: UTF-8 -*-

require 'fakeweb'

FakeWeb.allow_net_connect = %r[^https?://coveralls\.io]

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
  :body => html('<a href="bar1.pdf">bar1</a><a href="bar2.pdf">bar2</a>')
)

FakeWeb.register_uri(
  :get,
  "#{BASE_URL}/ab/so/lu/te",
  :body => html('<a href="/bar1.pdf">bar</a>')
)

FakeWeb.register_uri(
  :get,
  "#{BASE_URL}/malformed1",
  :body => html('<p><a href="/bar1.pdf">bar</p>')
)

FakeWeb.register_uri(
  :get,
  "#{BASE_URL}/malformed2",
  :body => html('<p><a href=bar1.pdf >bar</a></p>')
)

FakeWeb.register_uri(
  :get,
  "#{BASE_URL}/malformed3",
  :body => html('<p><a foo="bar" HrEF="/bar1.pdf" >bar</p>')
)

FakeWeb.register_uri(
  :get,
  "#{BASE_URL}/one",
  :body => html('<a href="/bar.pdf">bar1</a>')
)

FakeWeb.register_uri(
  :get,
  "#{BASE_URL}/two",
  :body => html('<a href="/bar.pdf">bar</a><a href="/foo.pdf">foo</a>')
)

# Issue #5
# https://github.com/bfontaine/sq/issues/5
FakeWeb.register_uri(
  :get,
  "#{BASE_URL}/issue5",
  :body => html(<<-EOH
    <ul>
    <li>quelques <a
    href="http://fr.wikipedia.org/wiki/Développement_décimal_de_l%27unité">e
    </a> sur</li>
    </ul>
EOH
  )
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
