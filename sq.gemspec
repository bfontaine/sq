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

    s.files         = ['lib/sq.rb']
    s.test_files    = Dir.glob('tests/*tests.rb')
    s.require_path  = 'lib'
    s.executables  << 'sq'

    s.add_runtime_dependency 'nokogiri', '~>1.6.1'
    s.add_runtime_dependency 'trollop',  '~>2.0'
    s.add_runtime_dependency 'colored',  '~>1.2'

    s.add_development_dependency 'simplecov'
    s.add_development_dependency 'rake'
    s.add_development_dependency 'test-unit'
    s.add_development_dependency 'fakeweb'
end
