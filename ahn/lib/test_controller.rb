# encoding: utf-8
require 'yaml'

class TestController < Adhearsion::CallController

  def run
    menus = YAML.load_file 'lib/menus.yml'
    answer
    menus.each { |m| test_menu m }
    hangup
  end

  def test_menu(opts)
    menu "#{sound_file opts['sound']}" do
      match(opts['incorrect_dtmf']) { hangup }
      match(opts['dtmf'])           { nil }
    end
  end

  def sound_file(filename)
    File.expand_path "./sounds/#{filename}.gsm"
  end

end
