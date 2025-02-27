<img src="/logo.svg" width="64px"/>

[![EO principles respected here](https://www.elegantobjects.org/badge.svg)](https://www.elegantobjects.org)
[![DevOps By Rultor.com](http://www.rultor.com/b/yegor256/total)](http://www.rultor.com/p/yegor256/total)
[![We recommend RubyMine](https://www.elegantobjects.org/rubymine.svg)](https://www.jetbrains.com/ruby/)

[![rake](https://github.com/yegor256/total/actions/workflows/rake.yml/badge.svg)](https://github.com/yegor256/total/actions/workflows/rake.yml)
[![Gem Version](https://badge.fury.io/rb/total.svg)](http://badge.fury.io/rb/total)
[![Maintainability](https://api.codeclimate.com/v1/badges/6e08ce63e597f241ccc7/maintainability)](https://codeclimate.com/github/yegor256/total/maintainability)
[![Yard Docs](http://img.shields.io/badge/yard-docs-blue.svg)](http://rubydoc.info/github/yegor256/total/master/frames)
[![License](https://img.shields.io/badge/license-MIT-green.svg)](https://github.com/yegor256/total/sibit/master/LICENSE.txt)
[![Test Coverage](https://img.shields.io/codecov/c/github/yegor256/total.svg)](https://codecov.io/github/yegor256/total?branch=master)
[![Hits-of-Code](https://hitsofcode.com/github/yegor256/total)](https://hitsofcode.com/view/github/yegor256/total)

Total is a Ruby gem to detect the total amount of memory in the system.

First, install it:

```bash
$ gem install total
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
  * <del>Windows</del> ([help wanted](https://github.com/yegor256/total/issues/3))

If the platform is not recognized or is not supported, `Total::CantDetect` exception
will be raised. You should catch it and proceed accordingly, for example:

```ruby
def total_mb
  Total::Mem.new.bytes / (1024 * 1024)
rescue Total::CantDetect
  512
end
```

This code will return the actual memory size in Mb, if it can be detected,
or 512 otherwise.

That's it.

## How to contribute

Read [these guidelines](https://www.yegor256.com/2014/04/15/github-guidelines.html).
Make sure your build is green before you contribute
your pull request. You will need to have [Ruby](https://www.ruby-lang.org/en/) 2.3+ and
[Bundler](https://bundler.io/) installed. Then:

```
$ bundle update
$ bundle exec rake
```

If it's clean and you don't see any error messages, submit your pull request.
