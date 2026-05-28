# frozen_string_literal: true

# SPDX-FileCopyrightText: Copyright (c) 2018-2026 Yegor Bugayenko
# SPDX-License-Identifier: MIT

# Linux specific.
#
# Author:: Yegor Bugayenko (yegor256@gmail.com)
# Copyright:: Copyright (c) 2018-2026 Yegor Bugayenko
# License:: MIT
class Total::Linux
  # Get the total in bytes
  def memory
    raise(Total::CantDetect) unless File.exist?('/proc/meminfo')
    File.readlines('/proc/meminfo').each do |t|
      return Integer(t.split(/ +/)[1]) * 1024 if t.start_with?('MemTotal:')
    end
    raise(Total::CantDetect, 'Can\'t detect memory size at /proc/meminfo')
  end
end
