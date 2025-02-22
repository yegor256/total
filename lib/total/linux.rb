# frozen_string_literal: true

# SPDX-FileCopyrightText: Copyright (c) 2018-2025 Yegor Bugayenko
# SPDX-License-Identifier: MIT

# Linux specific.
#
# Author:: Yegor Bugayenko (yegor256@gmail.com)
# Copyright:: Copyright (c) 2018-2025 Yegor Bugayenko
# License:: MIT
module Total
  # Linux specifics.
  class Linux
    # Get the total in bytes
    def memory
      raise CantDetect unless File.exist?('/proc/meminfo')
      File.readlines('/proc/meminfo').each do |t|
        return t.split(/ +/)[1].to_i * 1024 if t.start_with?('MemTotal:')
      end
      raise CantDetect, 'Can\'t detect memory size at /proc/meminfo'
    end
  end
end
