# -*- coding: UTF-8 -*-

require File.dirname(__FILE__) + '/fake_responses'

class SQ_query_test < Test::Unit::TestCase

  def setup
    @url  = 'example.com'
    @http = "http://#{@url}"
  end

  def test_no_links
    assert_equal([], SQ.query("#{@url}/no-links", /./))
  end

  def test_no_href
    assert_equal([], SQ.query("#{@url}/no-href", /./))
  end

  def test_no_pdfs
    assert_equal([], SQ.query("#{@url}/no-pdf", /./))
  end

  def test_no_match
    assert_equal([], SQ.query("#{@url}/bar", /foo/))
  end

  def test_full_match
    pdfs = [
      {:uri => "#{@http}/bar1.pdf", :name => 'bar1.pdf'},
      {:uri => "#{@http}/bar2.pdf", :name => 'bar2.pdf'}
    ]
    assert_equal(pdfs, SQ.query("#{@url}/bar", /./))
    assert_equal(pdfs, SQ.query("#{@http}/bar", /./))
  end

end
