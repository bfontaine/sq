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

    # query an URI and return a list of PDFs. Each PDF is an hash with three
    # keys: +:uri+ is its absolute URI, +:name+ is its name (last part of its
    # URI), and +:text+ is each link text.
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

    # Output a formatted filename.
    # @doc [Hash]   as returned from +SQ.query+.
    # @fmt [String]
    # @opts [Hash] additional info.
    def format(doc, fmt='%s.pdf', opts={})
      opts[:number] ||= 0
      opts[:count]  ||= 0

      fmt.gsub(/%./) do |f|
        case f
        when '%n' then opts[:number]
        when '%N' then opts[:number]+1
        when '%c' then opts[:count]
        when '%s' then doc[:name].sub(/\.pdf$/i, '')
        when '%S' then doc[:text]
        when '%_' then doc[:text].gsub(/\s+/, '_')
        when '%-' then doc[:text].gsub(/\s+/, '-')
        when '%%' then '%'
        end
      end
    end

    # query an URI and download all PDFs which match the regex. It returns the
    # number of downloaded PDFs.
    # @uri   [String]
    # @regex [Regexp] Regex to use to match PDF URIs
    # @opts  [Hash]   Supported options: +:verbose+, +:directory+ (specify the
    #                 directory to use for output instead of the current one),
    #                 and +:format+ the output format. See the README for
    #                 details.
    #
    def process(uri, regex=/./, opts={})
      uris = self.query(uri, regex)
      count = uris.count

      puts "Found #{count} PDFs:" if opts[:verbose]

      return 0 if uris.empty?

      out = File.expand_path(opts[:directory] || '.')
      fmt = opts[:format] || '%s.pdf'

      unless Dir.exists?(out)
        puts "-> mkdir #{out}" if opts[:verbose]
        FileUtils.mkdir_p(out)
      end

      p = ProgressBar.create(:title => "PDFs", :total => count)
      i = 0

      uris.each do |u|
        name = format(u, fmt, {:number => i, :count => count})
        i += 1
        open("#{out}/#{name}", 'wb') do |f|
          open(u[:uri], 'rb') do |resp|
            f.write(resp.read)
            p.log name if opts[:verbose]
            p.increment
          end
        end
      end.count
    end
  end
end
