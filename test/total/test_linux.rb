# frozen_string_literal: true

# SPDX-FileCopyrightText: Copyright (c) 2018-2025 Yegor Bugayenko
# SPDX-License-Identifier: MIT

require 'minitest/autorun'
require_relative '../../lib/total/linux'

# Linux test.
# Author:: Yegor Bugayenko (yegor256@gmail.com)
# Copyright:: Copyright (c) 2018-2025 Yegor Bugayenko
# License:: MIT
class LinuxTest < Minitest::Test
  def test_fetch_memory_size
    skip unless RUBY_PLATFORM.include?('linux')
    linux = Total::Linux.new
    assert(!linux.memory.nil?)
    assert(linux.memory > 1024 * 1024)
  end

  def test_crashes_when_cant_detect
    skip if RUBY_PLATFORM.include?('linux')
    assert_raises Total::CantDetect do
      Total::Linux.new.memory
    end
  end
end
