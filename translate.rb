require_relative 'lib/i18n_yaml_editor'
require 'yaml'

t = I18nYamlEditor::App.new Dir.pwd, :cs, :en
t.start