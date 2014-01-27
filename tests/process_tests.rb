# -*- coding: UTF-8 -*-

require 'tmpdir'
require 'fileutils'
require File.dirname(__FILE__) + '/fake_responses'

class SQ_process_test < Test::Unit::TestCase

  def setup
    @url  = 'example.com'
    @http = "http://#{@url}"

    @prev_path = Dir.pwd
    @test_path = Dir.mktmpdir('sq-tests')
    Dir.chdir @test_path
  end

  def teardown
    Dir.chdir @prev_path
    FileUtils.rm_rf @test_path
  end

  def test_no_links
    assert_equal(0, SQ.process("#{@url}/no-links", /./))
  end

  def test_one_link_no_dir
    assert_equal(1, SQ.process("#{@url}/one", /./))
    assert(File.exists?('bar.pdf'), 'bar.pdf exists')
    assert_equal('%PDFbar', File.read('bar.pdf'))
  end

  def test_one_link_existing_dir
    dir = 'foo'
    Dir.mkdir dir
    assert_equal(1, SQ.process("#{@url}/one", /./, :directory => dir))
    assert(File.exists?("#{dir}/bar.pdf"), "#{dir}/bar.pdf exists")
    assert_equal('%PDFbar', File.read("#{dir}/bar.pdf"))
  end

  def test_one_link_existing_subdir
    dir = 'foo/bar/qux'
    FileUtils.mkdir_p dir
    assert_equal(1, SQ.process("#{@url}/one", /./, :directory => dir))
    assert(File.exists?("#{dir}/bar.pdf"), "#{dir}/bar.pdf exists")
    assert_equal('%PDFbar', File.read("#{dir}/bar.pdf"))
  end

  def test_one_link_unexisting_subdir
    dir = 'foo/bar/qux'
    assert_equal(1, SQ.process("#{@url}/one", /./, :directory => dir))
    assert(Dir.exists?(dir), "#{dir} exists")
    assert(File.exists?("#{dir}/bar.pdf"), "#{dir}/bar.pdf exists")
    assert_equal('%PDFbar', File.read("#{dir}/bar.pdf"))
  end

  def test_two_links_unexisting_subdir
    dir = 'foo/bar/qux'
    assert_equal(2, SQ.process("#{@url}/two", /./, :directory => dir))
    assert(Dir.exists?(dir), "#{dir} exists")

    assert(File.exists?("#{dir}/bar.pdf"), "#{dir}/bar.pdf exists")
    assert_equal('%PDFbar', File.read("#{dir}/bar.pdf"))

    assert(File.exists?("#{dir}/foo.pdf"), "#{dir}/foo.pdf exists")
    assert_equal('%PDFfoo', File.read("#{dir}/foo.pdf"))
  end

end
