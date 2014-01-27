# -*- coding: UTF-8 -*-

require 'uri'
require 'open-uri'
require 'nokogiri'
require 'fileutils'
require 'ruby-progressbar'
require File.expand_path(File.dirname __FILE__) + '/version'

module SQ
  class << self
    # return the user-agent used by SQ
    def user_agent
      "SQ/#{version} +github.com/bfontaine/sq"
    end

    # query an URI and return a list of PDFs. Each PDF is an hash with two
    # keys: :uri is its absolute URI, :name is its name (last part of its URI).
    # @uri [String]
    # @regex [Regexp]
    def query(uri, regex=/./)
      uri = 'http://' + uri unless uri =~ /^https?:\/\//

      doc = Nokogiri::HTML(open(uri, 'User-Agent' => user_agent))
      links = doc.css('a[href]')

      uris = links.map { |a| [a.text, URI.join(uri, a.attr('href'))] }
      uris.select! { |_,u| u.path =~ /\.pdf$/i && u.to_s =~ regex }

      uris.map do |text,u|
        {
          :uri => u.to_s,
          :name => u.path.split('/').last,
          :text => text
        }
      end
    end

    # query an URI and download all PDFs which match the regex. It returns the
    # number of downloaded PDFs.
    # @uri   [String]
    # @regex [Regexp] Regex to use to match PDF URIs
    # @opts  [Hash]   Supported options: :verbose, :directory (specify the
    #                 directory to use for output instead of the current one)
    def process(uri, regex=/./, opts={})
      uris = self.query(uri, regex)
      count = uris.count

      puts "Found #{count} PDFs:" if opts[:verbose]

      return 0 if uris.empty?

      out = File.expand_path(opts[:directory] || '.')

      unless Dir.exists?(out)
        puts "-> mkdir #{out}" if opts[:verbose]
        FileUtils.mkdir_p(out)
      end

      p = ProgressBar.create(:title => "PDFs", :total => count)

      uris.each do |u|
        open("#{out}/#{u[:name]}", 'wb') do |f|
          open(u[:uri], 'rb') do |resp|
            f.write(resp.read)
            p.log u[:name] if opts[:verbose]
            p.increment
          end
        end
      end.count
    end
  end
end
