# frozen_string_literal: true

# SPDX-FileCopyrightText: Copyright (c) 2018-2025 Yegor Bugayenko
# SPDX-License-Identifier: MIT

require 'English'
lib = File.expand_path('lib', __dir__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require_relative 'lib/total/version'
Gem::Specification.new do |s|
  s.required_rubygems_version = Gem::Requirement.new('>= 0') if s.respond_to? :required_rubygems_version=
  s.required_ruby_version = '>= 2.3'
  s.name = 'total'
  s.version = Total::VERSION
  s.license = 'MIT'
  s.summary = 'Total memory calculator in Ruby'
  s.description = 'Get total memory size of the system'
  s.authors = ['Yegor Bugayenko']
  s.email = 'yegor256@gmail.com'
  s.homepage = 'https://github.com/yegor256/total'
  s.files = `git ls-files`.split($RS)
  s.rdoc_options = ['--charset=UTF-8']
  s.extra_rdoc_files = ['README.md']
  s.add_development_dependency 'codecov', '0.6.0'
  s.add_development_dependency 'minitest', '5.18.0'
  s.add_development_dependency 'rake', '13.0.6'
  s.add_development_dependency 'rdoc', '6.5.0'
  s.add_development_dependency 'rubocop', '1.48.1'
  s.add_development_dependency 'rubocop-rspec', '2.19.0'
  s.metadata['rubygems_mfa_required'] = 'true'
end
