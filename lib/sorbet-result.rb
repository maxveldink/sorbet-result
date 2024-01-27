# rubocop:disable Naming/FileName
# rubocop:enable Naming/FileName
# typed: strict
# frozen_string_literal: true

require "sorbet-runtime"
require "zeitwerk"
require_relative "typed/result"

# Sorbet-aware namespace to super-charge your projects
module Typed; end

loader = Zeitwerk::Loader.new
loader.push_dir("#{__dir__}/typed", namespace: Typed)
loader.setup
