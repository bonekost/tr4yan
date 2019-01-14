module I18nYamlEditor
  class << self
    attr_accessor :app
  end
end

require_relative "i18n_yaml_editor/app"
require_relative "i18n_yaml_editor/category"
require_relative "i18n_yaml_editor/key"
require_relative "i18n_yaml_editor/store"
require_relative "i18n_yaml_editor/transformation"
require_relative "i18n_yaml_editor/translation"
require_relative "i18n_yaml_editor/translate"
