# frozen_string_literal: true

# SPDX-FileCopyrightText: Copyright (c) 2018-2025 Yegor Bugayenko
# SPDX-License-Identifier: MIT

# Windows specific.
#
# Author:: Yegor Bugayenko (yegor256@gmail.com)
# Copyright:: Copyright (c) 2018-2025 Yegor Bugayenko
# License:: MIT
module Total
  # Windows specifics.
  class Windows
    # Get the total in bytes
    # 
    # Try multiple methods for different Windows environments
    # Method 1: Try wmic (traditional Windows command)
    # Method 2: Try PowerShell (available in MSYS2 and most Windows environments)
    # Method 3: Try systeminfo command
    #
    # @return [Integer] the total amount of memory in bytes
    # @raise [CantDetect] If all methods not available or failed
    def memory      
      begin
        output = `wmic computersystem get TotalPhysicalMemory /value 2>NUL`.strip
        output.split("\n").each do |line|
          next unless line.start_with?('TotalPhysicalMemory=')
          memory_bytes = line.split('=')[1].to_i
          return memory_bytes if memory_bytes > 0
        end
      rescue Errno::ENOENT, StandardError
        # wmic not available or failed, try other methods
      end      
      begin
        output = `powershell.exe -Command "Get-WmiObject -Class Win32_ComputerSystem | Select-Object -ExpandProperty TotalPhysicalMemory" 2>NUL`.strip
        memory_bytes = output.to_i
        return memory_bytes if memory_bytes > 0
      rescue Errno::ENOENT, StandardError
        # PowerShell not available or failed
      end      
      begin
        output = `systeminfo 2>NUL`.strip
        output.split("\n").each do |line|
          if line.match(/Total Physical Memory:\s*(.+)/i)
            # Parse memory string like "16,384 MB" or "16.384 MB"
            memory_str = $1.strip
            if memory_str =~ /([0-9,.\s]+)\s*MB/i
              memory_mb = $1.gsub(/[,\s]/, '').to_f
              return (memory_mb * 1024 * 1024).to_i
            elsif memory_str =~ /([0-9,.\s]+)\s*GB/i
              memory_gb = $1.gsub(/[,\s]/, '').to_f
              return (memory_gb * 1024 * 1024 * 1024).to_i
            end
          end
        end
      rescue Errno::ENOENT, StandardError
        # systeminfo not available or failed
      end      
      raise CantDetect, 'Can\'t detect memory size via wmic, PowerShell, or systeminfo'
    end
  end
end