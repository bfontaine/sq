# sq

[![Build Status](https://travis-ci.org/bfontaine/sq.png?branch=master)](https://travis-ci.org/bfontaine/sq)

**sq** is a web scrapping tool for PDFs. Give it an URL and an optional regex,
and it’ll download all PDFs linked on it.

## Install

```
gem install sq
```

## Usage

From the command-line:

```
$ sq [-o <directory>] <url> [<regex>]
```

Available options:

- `-o`: choose the output directory
- `-V`: be more verbose

The regex is case-sensitive and is matched against the whole URL.

In a Ruby file:

```ruby
require 'sq'

urls = SQ.query('http://example.com', /important/i)
```

## Tests

```
$ git clone https://github.com/bfontaine/sq.git
$ cd sq
$ bundle install
$ rake test
```

Set the `COVERAGE` environment variable to activate the code
coverage report, e.g.:

```
$ export COVERAGE=1; rake test
```


It’ll generate a `coverage/index.html`, which you can open in a
Web browser.
