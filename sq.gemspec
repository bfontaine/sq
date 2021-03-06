require './lib/sq'

Gem::Specification.new do |s|
    s.name          = 'sq'
    s.version       = SQ.version
    s.date          = Time.now

    s.summary       = 'Bulk PDFs downloader'
    s.description   = 'Download all PDFs linked in a Web page'
    s.license       = 'MIT'

    s.author        = 'Baptiste Fontaine'
    s.email         = 'batifon@yahoo.fr'
    s.homepage      = 'https://github.com/bfontaine/sq'

    s.files         = Dir['lib/*.rb']
    s.test_files    = Dir['tests/*tests.rb']
    s.require_path  = 'lib'
    s.executables  << 'sq'

    s.signing_key   = File.expand_path('~/.gem/gem-private_key.pem')
    s.cert_chain    = ['certs/bfontaine.pem']

    s.add_runtime_dependency 'nokogiri', '~>1.6'
    s.add_runtime_dependency 'trollop',  '~>2.0'
    s.add_runtime_dependency 'ruby-progressbar', '~>1.4'

    s.add_development_dependency 'simplecov', '~>0.8'
    s.add_development_dependency 'rake', '~>10.1'
    s.add_development_dependency 'test-unit', '~>2.5'
    s.add_development_dependency 'fakeweb', '~>1.3'
    s.add_development_dependency 'coveralls', '~>0.7'
end
