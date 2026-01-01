# frozen_string_literal: true

# SPDX-FileCopyrightText: Copyright (c) 2018-2026 Yegor Bugayenko
# SPDX-License-Identifier: MIT

# OSX specific.
#
# Author:: Yegor Bugayenko (yegor256@gmail.com)
# Copyright:: Copyright (c) 2018-2026 Yegor Bugayenko
# License:: MIT
module Total
  # OSX specifics.
  class OSX
    # Get the total in bytes
    def memory
      begin
        `sysctl -a`.split("\n").each do |t|
          return t.split[1].to_i if t.start_with?('hw.memsize:')
        end
      rescue Errno::ENOENT => e
        raise CantDetect, e.message
      end
      raise CantDetect, 'Can\'t detect memory size via sysctl'
    end
  end
end
