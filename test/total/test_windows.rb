# frozen_string_literal: true

# SPDX-FileCopyrightText: Copyright (c) 2018-2025 Yegor Bugayenko
# SPDX-License-Identifier: MIT

require 'minitest/autorun'
require_relative '../../lib/total'

# Windows test.
# Author:: Yegor Bugayenko (yegor256@gmail.com)
# Copyright:: Copyright (c) 2018-2025 Yegor Bugayenko
# License:: MIT
class WindowsTest < Minitest::Test
  def test_fetch_memory_size
    skip unless windows_platform?
    windows = Total::Windows.new
    refute_nil(windows.memory)
    assert_operator(windows.memory, :>, 1024 * 1024)
  end

  def test_crashes_when_cant_detect
    skip if windows_platform?
    assert_raises Total::CantDetect do
      Total::Windows.new.memory
    end
  end

  private

  def windows_platform?
    RUBY_PLATFORM.include?('mingw') ||
      RUBY_PLATFORM.include?('mswin') ||
      RUBY_PLATFORM.include?('cygwin') ||
      RUBY_PLATFORM.include?('ucrt')
  end
end
