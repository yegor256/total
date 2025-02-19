# frozen_string_literal: true

# (The MIT License)
#
# SPDX-FileCopyrightText: Copyright (c) 2018-2025 Yegor Bugayenko
# SPDX-License-Identifier: MIT

require 'minitest/autorun'
require_relative '../../lib/total/freebsd'

# FreeBSD test.
# Author:: Yegor Bugayenko (yegor256@gmail.com)
# Copyright:: Copyright (c) 2018-2025 Yegor Bugayenko
# License:: MIT
class FreeBSDTest < Minitest::Test
  def test_fetch_memory_size
    skip unless RUBY_PLATFORM.include?('freebsd')
    freebsd = Total::FreeBSD.new
    assert(!freebsd.memory.nil?)
    assert(freebsd.memory > 1024 * 1024)
  end

  def test_crashes_when_cant_detect
    skip if RUBY_PLATFORM.include?('freebsd')
    assert_raises Total::CantDetect do
      Total::FreeBSD.new.memory
    end
  end
end
