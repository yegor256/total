# Get Total Memory Size

[![EO principles respected here](https://www.elegantobjects.org/badge.svg)](https://www.elegantobjects.org)
[![DevOps By Rultor.com](https://www.rultor.com/b/yegor256/total)](https://www.rultor.com/p/yegor256/total)
[![We recommend RubyMine](https://www.elegantobjects.org/rubymine.svg)](https://www.jetbrains.com/ruby/)

[![rake](https://github.com/yegor256/total/actions/workflows/rake.yml/badge.svg)](https://github.com/yegor256/total/actions/workflows/rake.yml)
[![Gem Version](https://badge.fury.io/rb/total.svg)](https://badge.fury.io/rb/total)
[![Maintainability](https://api.codeclimate.com/v1/badges/6e08ce63e597f241ccc7/maintainability)](https://codeclimate.com/github/yegor256/total/maintainability)
[![Yard Docs](https://img.shields.io/badge/yard-docs-blue.svg)](https://rubydoc.info/github/yegor256/total/master/frames)
[![License](https://img.shields.io/badge/license-MIT-green.svg)](https://github.com/yegor256/total/sibit/master/LICENSE.txt)
[![Test Coverage](https://img.shields.io/codecov/c/github/yegor256/total.svg)](https://codecov.io/github/yegor256/total?branch=master)
[![Hits-of-Code](https://hitsofcode.com/github/yegor256/total)](https://hitsofcode.com/view/github/yegor256/total)

This Ruby gem helps you detect the total amount of memory in the system.

First, install it:

```bash
gem install total
```

Then, use it like this:

```ruby
require 'total'
puts Total::Mem.new.bytes
```

The following platforms are supported:

  * MacOSX
  * Linux
  * FreeBSD
  * Windows (including MSYS2/MinGW, MSVC, and Cygwin environments)

If the platform is not recognized or is not supported,
  the `Total::CantDetect` exception is raised.
You catch it and proceed accordingly, for example:

```ruby
def total_mb
  Total::Mem.new.bytes / (1024 * 1024)
rescue Total::CantDetect
  512
end
```

This code returns the actual memory size in Mb,
  if it can be detected, or 512 otherwise.

That's it.

## How to contribute

Read these [guidelines].
Make sure your build is green before you contribute your pull request.
You need to have [Ruby](https://www.ruby-lang.org/en/) 2.3+ and
[Bundler](https://bundler.io/) installed. Then:

```bash
bundle update
bundle exec rake
```

If it's clean and you don't see any error messages, submit your pull request.

[guidelines]: https://www.yegor256.com/2014/04/15/github-guidelines.html
