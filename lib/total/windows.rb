# frozen_string_literal: true

# SPDX-FileCopyrightText: Copyright (c) 2018-2026 Yegor Bugayenko
# SPDX-License-Identifier: MIT

# Windows specific.
#
# Author:: Yegor Bugayenko (yegor256@gmail.com)
# Copyright:: Copyright (c) 2018-2026 Yegor Bugayenko
# License:: MIT
module Total
  # Windows specifics.
  class Windows
    # Detects the total physical memory available on Windows systems.
    #
    # This method attempts to determine the system's total RAM using multiple
    # detection strategies to ensure compatibility across different Windows
    # environments and configurations.
    #
    # Detection methods (tried in order):
    # 1. **wmic**: Windows Management Instrumentation Command-line tool
    #    - Most reliable on traditional Windows installations
    #    - Uses: `wmic computersystem get TotalPhysicalMemory /value`
    # 2. **PowerShell**: Windows PowerShell with WMI queries
    #    - Available on Windows 7+ and MSYS2 environments
    #    - Uses: `Get-WmiObject -Class Win32_ComputerSystem`
    # 3. **systeminfo**: Built-in Windows system information utility
    #    - Fallback method for restricted environments
    #    - Parses output to extract memory information in MB/GB format
    #
    # @return [Integer] the total amount of physical memory in bytes
    # @raise [CantDetect] if all detection methods fail or are unavailable
    #
    # @example Typical usage
    #   windows = Total::Windows.new
    #   total_memory = windows.memory
    #   puts "Total RAM: #{total_memory / (1024**3)} GB"
    #
    # @note This method requires at least one of the Windows utilities
    #   (wmic, powershell.exe, or systeminfo) to be available in the system PATH
    def memory
      try_wmic || try_powershell || try_systeminfo ||
        raise(CantDetect, 'Can\'t detect memory size via wmic, PowerShell, or systeminfo')
    end

    private

    # Try to get memory using wmic command
    # @return [Integer, nil] memory in bytes or nil if failed
    def try_wmic
      output = `wmic computersystem get TotalPhysicalMemory /value 2>NUL`.strip
      output.split("\n").each do |line|
        next unless line.start_with?('TotalPhysicalMemory=')
        memory_bytes = line.split('=')[1].to_i
        return memory_bytes if memory_bytes.positive?
      end
      nil
    rescue StandardError
      nil
    end

    # Try to get memory using PowerShell
    # @return [Integer, nil] memory in bytes or nil if failed
    def try_powershell
      command = 'powershell.exe -Command "Get-WmiObject -Class Win32_ComputerSystem | ' \
                'Select-Object -ExpandProperty TotalPhysicalMemory" 2>NUL'
      output = `#{command}`.strip
      memory_bytes = output.to_i
      return memory_bytes if memory_bytes.positive?
      nil
    rescue StandardError
      nil
    end

    # Try to get memory using systeminfo command
    # @return [Integer, nil] memory in bytes or nil if failed
    def try_systeminfo
      output = `systeminfo 2>NUL`.strip
      output.split("\n").each do |line|
        next unless line =~ /Total Physical Memory:\s*(.+)/i
        return parse_memory_string(::Regexp.last_match(1).strip)
      end
      nil
    rescue StandardError
      nil
    end

    # Parse memory string from systeminfo output
    # @param memory_str [String] memory string like "16,384 MB" or "16.384 MB"
    # @return [Integer, nil] memory in bytes or nil if parsing failed
    def parse_memory_string(memory_str)
      if memory_str =~ /([0-9,.\s]+)\s*MB/i
        memory_mb = ::Regexp.last_match(1).gsub(/[,\s]/, '').to_f
        (memory_mb * 1024 * 1024).to_i
      elsif memory_str =~ /([0-9,.\s]+)\s*GB/i
        memory_gb = ::Regexp.last_match(1).gsub(/[,\s]/, '').to_f
        (memory_gb * 1024 * 1024 * 1024).to_i
      end
    end
  end
end
