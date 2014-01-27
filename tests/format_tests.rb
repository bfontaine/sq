# -*- coding: UTF-8 -*-

class SQ_format_test < Test::Unit::TestCase

  def setup
    @foo = {
      :text => 'Foo',
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

end
