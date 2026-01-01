# frozen_string_literal: true

# SPDX-FileCopyrightText: Copyright (c) 2018-2026 Yegor Bugayenko
# SPDX-License-Identifier: MIT

require 'minitest/autorun'
require_relative '../../lib/total/osx'

# OSX test.
# Author:: Yegor Bugayenko (yegor256@gmail.com)
# Copyright:: Copyright (c) 2018-2026 Yegor Bugayenko
# License:: MIT
class OSXTest < Minitest::Test
  def test_fetch_memory_size
    skip unless RUBY_PLATFORM.include?('darwin')
    linux = Total::OSX.new
    refute_nil(linux.memory)
    assert_operator(linux.memory, :>, 1024 * 1024)
  end

  def test_crashes_when_cant_detect
    skip if RUBY_PLATFORM.include?('darwin')
    assert_raises Total::CantDetect do
      Total::OSX.new.memory
    end
  end
end
