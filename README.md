# sq

[![Build Status](https://travis-ci.org/bfontaine/sq.png?branch=master)](https://travis-ci.org/bfontaine/sq)
[![Gem Version](https://badge.fury.io/rb/sq.png)](http://badge.fury.io/rb/sq)
[![Coverage Status](https://coveralls.io/repos/bfontaine/sq/badge.png)](https://coveralls.io/r/bfontaine/sq)
[![Inline docs](http://inch-ci.org/github/bfontaine/sq.png)](http://inch-ci.org/github/bfontaine/sq)

**sq** is a web scrapping tool for PDFs. Give it an URL and an optional regex,
and it’ll download all PDFs linked on it.

## Install

```
gem install sq
```

## Usage

From the command-line:

```
$ sq [-o <directory>] [-F <format>] <url> [<regex>]
```

Available options:

- `-F`: output format (see below), default is `%s.pdf`
- `-o`: choose the output directory
- `-V`: be more verbose
- `--formats`: list available formats

The regex is case-sensitive and is matched against the whole URL.

### Examples

```sh
# Get all PDFs from a Web page
sq http://liafa.fr/~yunes/cours/interfaces/

# Use a regexp to get only those you want
sq http://liafa.fr/~yunes/cours/interfaces/ 'fiches/\d+'

# Be more verbose
sq -V http://liafa.fr/~yunes/cours/interfaces/ 'fiches/\d+'

# Add a filename format
sq -V http://liafa.fr/~yunes/cours/interfaces/ 'fiches/\d+' -F 'class-%Z.pdf'
```

### Formats

The output format is used for each PDF filename. It’s a string with zero or
more special strings that will be replaced by a special value.

```
%n - PDF number, starting at 0
%N - PDF number, starting at 1
%z - same as %n, but zero-padded
%Z - same as %N, but zero-padded
%c - total number of PDFs
%s - name of the PDF, extracted from its URI, without `.pdf`
%S - name of the PDF, extracted from the link text
%_ - same as %S, but spaces are replaced with underscores
%- - same as %S, but spaces are replaced with hyphens
%% - litteral %
```

## API

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

It’ll generate a `coverage/index.html`, which you can open in a Web browser.
