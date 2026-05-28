# frozen_string_literal: true

# SPDX-FileCopyrightText: Copyright (c) 2018-2026 Yegor Bugayenko
# SPDX-License-Identifier: MIT

# Windows specific.
#
# Author:: Yegor Bugayenko (yegor256@gmail.com)
# Copyright:: Copyright (c) 2018-2026 Yegor Bugayenko
# License:: MIT
class Total::Windows
  # Detects the total physical memory available on Windows systems.
  #
  # @return [Integer] the total amount of physical memory in bytes
  # @raise [CantDetect] if all detection methods fail or are unavailable
  def memory
    wmic || powershell || sysinfo ||
      raise(Total::CantDetect, 'Can\'t detect memory size via wmic, PowerShell, or systeminfo')
  end

  private

  # Try to get memory using wmic command
  def wmic
    output = `wmic computersystem get TotalPhysicalMemory /value 2>NUL`.strip
    output.split("\n").each do |line|
      next unless line.start_with?('TotalPhysicalMemory=')
      bytes = Integer(line.split('=')[1])
      return bytes if bytes.positive?
    end
    nil
  rescue StandardError
    nil
  end

  # Try to get memory using PowerShell
  def powershell
    bytes = Integer(
      `powershell.exe -Command "Get-WmiObject -Class Win32_ComputerSystem | Select-Object -ExpandProperty TotalPhysicalMemory" 2>NUL`.strip
    )
    return bytes if bytes.positive?
    nil
  rescue StandardError
    nil
  end

  # Try to get memory using systeminfo command
  def sysinfo
    `systeminfo 2>NUL`.strip.split("\n").each do |line|
      next unless line =~ /Total Physical Memory:\s*(.+)/i
      return parse(::Regexp.last_match(1).strip)
    end
    nil
  rescue StandardError
    nil
  end

  # Parse memory string from systeminfo output
  def parse(str)
    if str =~ /([0-9,.\s]+)\s*MB/i
      Integer(Float(::Regexp.last_match(1).gsub(/[,\s]/, '')) * 1024 * 1024)
    elsif str =~ /([0-9,.\s]+)\s*GB/i
      Integer(Float(::Regexp.last_match(1).gsub(/[,\s]/, '')) * 1024 * 1024 * 1024)
    end
  end
end
