# frozen_string_literal: true

# (The MIT License)
#
# Copyright (c) 2018 Yegor Bugayenko
#
# Permission is hereby granted, free of charge, to any person obtaining a copy
# of this software and associated documentation files (the 'Software'), to deal
# in the Software without restriction, including without limitation the rights
# to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
# copies of the Software, and to permit persons to whom the Software is
# furnished to do so, subject to the following conditions:
#
# The above copyright notice and this permission notice shall be included in all
# copies or substantial portions of the Software.
#
# THE SOFTWARE IS PROVIDED 'AS IS', WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
# IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
# FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
# AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
# LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
# OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE
# SOFTWARE.

require_relative 'total/linux'
require_relative 'total/osx'

# Total is a simple class to detect the total amount of memory in the system.
#
#  require 'total'
#  bytes = Total::Mem.new.bytes
#
# For more information read
# {README}[https://github.com/yegor256/total/blob/master/README.md] file.
#
# Author:: Yegor Bugayenko (yegor256@gmail.com)
# Copyright:: Copyright (c) 2018 Yegor Bugayenko
# License:: MIT
module Total
  # Memory specifics.
  class Mem
    # Get it in bytes.
    def bytes
      target.memory
    end

    private

    # Target object to calculate memory size.
    def target
      return Total::OSX.new if RUBY_PLATFORM.include?('darwin')
      return Total::Linux.new if RUBY_PLATFORM.include?('linux')
      raise "Can\'t detect operating system: #{RUBY_PLATFORM}"
    end
  end
end
