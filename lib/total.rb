# frozen_string_literal: true

# SPDX-FileCopyrightText: Copyright (c) 2018-2025 Yegor Bugayenko
# SPDX-License-Identifier: MIT

require_relative 'total/linux'
require_relative 'total/freebsd'
require_relative 'total/osx'
require_relative 'total/windows'

# Total is a simple class to detect the total amount of memory in the system.
#
#  require 'total'
#  bytes = Total::Mem.new.bytes
#
# For more information read
# {README}[https://github.com/yegor256/total/blob/master/README.md] file.
#
# Author:: Yegor Bugayenko (yegor256@gmail.com)
# Copyright:: Copyright (c) 2018-2025 Yegor Bugayenko
# License:: MIT
module Total
  # When it's impossible to detect something.
  class CantDetect < StandardError; end

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
      return Total::FreeBSD.new if RUBY_PLATFORM.include?('freebsd')
      return Total::Windows.new if RUBY_PLATFORM =~ /mingw|mswin|cygwin|ucrt/
      raise CantDetect, "Can't detect operating system: #{RUBY_PLATFORM}"
    end
  end
end
