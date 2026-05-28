# frozen_string_literal: true

# SPDX-FileCopyrightText: Copyright (c) 2018-2026 Yegor Bugayenko
# SPDX-License-Identifier: MIT

require 'minitest/autorun'
require_relative '../../lib/total'

# Windows test.
# Author:: Yegor Bugayenko (yegor256@gmail.com)
# Copyright:: Copyright (c) 2018-2026 Yegor Bugayenko
# License:: MIT
class WindowsTest < Minitest::Test
  def test_fetch_memory_size
    skip unless windows
    refute_nil(Total::Windows.new.memory)
    assert_operator(Total::Windows.new.memory, :>, 1024 * 1024)
  end

  def test_crashes_when_cant_detect
    skip if windows
    assert_raises(Total::CantDetect) do
      Total::Windows.new.memory
    end
  end

  private

  def windows
    RUBY_PLATFORM =~ /mingw|mswin|cygwin|ucrt/
  end
end
