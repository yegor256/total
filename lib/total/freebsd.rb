# frozen_string_literal: true

# SPDX-FileCopyrightText: Copyright (c) 2018-2026 Yegor Bugayenko
# SPDX-License-Identifier: MIT

# FreeBSD specific.
#
# Author:: Yegor Bugayenko (yegor256@gmail.com)
# Copyright:: Copyright (c) 2018-2026 Yegor Bugayenko
# License:: MIT
class Total::FreeBSD
  # Get the total in bytes
  def memory
    `sysctl -a`.split("\n").each do |t|
      return Integer(t.split[1]) if t.start_with?('hw.physmem:')
    end
    raise(Total::CantDetect, 'Can\'t detect memory size via sysctl')
  rescue Errno::ENOENT => e
    raise(Total::CantDetect, e.message)
  end
end
