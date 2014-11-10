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
      {:uri => "#{@http}/bar1.pdf", :name => 'bar1.pdf', :text => 'bar1'},
      {:uri => "#{@http}/bar2.pdf", :name => 'bar2.pdf', :text => 'bar2'}
    ]
    assert_equal(pdfs, SQ.query("#{@url}/bar", /./))
    assert_equal(pdfs, SQ.query("#{@http}/bar", /./))
  end

  def test_absolute_path
    pdfs = [
      {:uri => "#{@http}/bar1.pdf", :name => 'bar1.pdf', :text => 'bar'}
    ]
    assert_equal(pdfs, SQ.query("#{@url}/ab/so/lu/te", /./))
  end

  def test_malformed_html
    pdfs = [
      {:uri => "#{@http}/bar1.pdf", :name => 'bar1.pdf', :text => 'bar'}
    ]
    assert_equal(pdfs, SQ.query("#{@url}/malformed1", /./))
    assert_equal(pdfs, SQ.query("#{@url}/malformed2", /./))
    assert_equal(pdfs, SQ.query("#{@url}/malformed3", /./))
  end

  def test_issue_5
    assert_equal([], SQ.query("#{@url}/issue5", /./))
  end

end
