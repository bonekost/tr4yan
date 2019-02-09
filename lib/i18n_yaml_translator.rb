
module I18nYamlTranslator
  class << self
    attr_accessor :app
  end
end

require_relative "i18n_yaml_translator/app"
require_relative "i18n_yaml_translator/category"
require_relative "i18n_yaml_translator/key"
require_relative "i18n_yaml_translator/store"
require_relative "i18n_yaml_translator/transformation"
require_relative "i18n_yaml_translator/translation"
require_relative "i18n_yaml_translator/translate"
