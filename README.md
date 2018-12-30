[![EO principles respected here](http://www.elegantobjects.org/badge.svg)](http://www.elegantobjects.org)
[![DevOps By Rultor.com](http://www.rultor.com/b/yegor256/total)](http://www.rultor.com/p/yegor256/total)
[![We recommend RubyMine](http://www.elegantobjects.org/rubymine.svg)](https://www.jetbrains.com/ruby/)

[![Build Status](https://travis-ci.org/yegor256/total.svg)](https://travis-ci.org/yegor256/total)
[![Gem Version](https://badge.fury.io/rb/total.svg)](http://badge.fury.io/rb/total)
[![Maintainability](https://api.codeclimate.com/v1/badges/6e08ce63e597f241ccc7/maintainability)](https://codeclimate.com/github/yegor256/total/maintainability)
[![Yard Docs](http://img.shields.io/badge/yard-docs-blue.svg)](http://rubydoc.info/github/yegor256/total/master/frames)

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
  * <del>FreeBSD</del> (help needed)
  * <del>Windows</del> (help needed)

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

# How to contribute

Read [these guidelines](https://www.yegor256.com/2014/04/15/github-guidelines.html).
Make sure you build is green before you contribute
your pull request. You will need to have [Ruby](https://www.ruby-lang.org/en/) 2.3+ and
[Bundler](https://bundler.io/) installed. Then:

```
$ bundle update
$ bundle exec rake
```

If it's clean and you don't see any error messages, submit your pull request.

# License

(The MIT License)

Copyright (c) 2018 Yegor Bugayenko

Permission is hereby granted, free of charge, to any person obtaining a copy
of this software and associated documentation files (the 'Software'), to deal
in the Software without restriction, including without limitation the rights
to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
copies of the Software, and to permit persons to whom the Software is
furnished to do so, subject to the following conditions:

The above copyright notice and this permission notice shall be included in all
copies or substantial portions of the Software.

THE SOFTWARE IS PROVIDED 'AS IS', WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE
SOFTWARE.
