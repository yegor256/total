# frozen_string_literal: true

# SPDX-FileCopyrightText: Copyright (c) 2018-2025 Yegor Bugayenko
# SPDX-License-Identifier: MIT

require 'minitest/autorun'
require_relative '../lib/total'

# Total test.
# Author:: Yegor Bugayenko (yegor256@gmail.com)
# Copyright:: Copyright (c) 2018-2025 Yegor Bugayenko
# License:: MIT
class TotalTest < Minitest::Test
  def test_simple_fetch
    mem = Total::Mem.new
    assert(!mem.bytes.nil?)
    assert(mem.bytes > 1024 * 1024)
  end
end
