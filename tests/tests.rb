#! /usr/bin/env ruby
# -*- coding: UTF-8 -*-

require 'test/unit'
require 'simplecov'

test_dir = File.expand_path( File.dirname(__FILE__) )

SimpleCov.start { add_filter '/tests/' } if ENV['COVERAGE']

require 'sq'

for t in Dir.glob( File.join( test_dir,  '*_tests.rb' ) )
  require t
end

class SQTests < Test::Unit::TestCase

  # == SQ#version == #

  def test_sq_version
    assert(SQ.version =~ /^\d+\.\d+\.\d+/)
  end

  # == SQ#user_agent == #
  def test_sq_ua
    assert(SQ.user_agent =~ /^SQ\/\d+\.\d+\.\d+/)
  end

end


exit Test::Unit::AutoRunner.run
