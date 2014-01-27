# -*- coding: UTF-8 -*-

class SQ_format_test < Test::Unit::TestCase

  def setup
    @foo = {
      :text => 'Foo Bar',
      :url  => 'http://example.com/foo.pdf',
      :name => 'foo.pdf'
    }

    @opts = { :count => 42, :number => 0 }
  end

  def test_empty_format
    assert_equal('', SQ.format(@foo, '', @opts))
  end

  def test_format_litteral
    assert_equal('%', SQ.format(@foo, '%%', @opts))
  end

  def test_format_pdf_number0
    assert_equal('0', SQ.format(@foo, '%n', @opts))
  end

  def test_format_pdf_number1
    assert_equal('1', SQ.format(@foo, '%N', @opts))
  end

  def test_format_pdf_count
    assert_equal('42', SQ.format(@foo, '%c', @opts))
  end

  def test_format_pdf_name
    assert_equal('foo', SQ.format(@foo, '%s', @opts))
  end

  def test_format_link_text
    assert_equal(@foo[:text], SQ.format(@foo, '%S', @opts))
  end

  def test_format_link_text_underscores
    assert_equal('Foo_Bar', SQ.format(@foo, '%_', @opts))
  end

  def test_format_link_text_hyphens
    assert_equal('Foo-Bar', SQ.format(@foo, '%-', @opts))
  end

  def test_format_no_special
    assert_equal('foo-qux', SQ.format(@foo, 'foo-qux', @opts))
  end

  def test_format_multiple_percentsigns
    assert_equal('%%%', SQ.format(@foo, '%%%%%%', @opts))
  end

  def test_format_multiple_placeholders
    assert_equal('0-1-Foo-Bar', SQ.format(@foo, '%n-%N-%-', @opts))
  end

end
