require_relative 'yandex-api/version'
require_relative 'yandex-api/translate'

module Yandex
  module API
    class RuntimeError < RuntimeError ; end
    class NotFound < RuntimeError ; end
  end
end
