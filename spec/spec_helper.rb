require 'sim_launcher'
require 'calabash-cucumber/operations'
require 'dotenv'

include Calabash::Cucumber::Core
include Calabash::Cucumber::TestsHelpers
include Calabash::Cucumber::WaitHelpers
include Calabash::Cucumber::KeyboardHelpers

Dotenv.load

RSpec.configure do |config|
  config.treat_symbols_as_metadata_keys_with_true_values = true
  config.run_all_when_everything_filtered = true
  config.filter_run :focus
  config.order = 'random'

  config.before do
    @calabash_launcher = Calabash::Cucumber::Launcher.new
    @calabash_launcher.attach
    unless @calabash_launcher.calabash_no_launch?
      @calabash_launcher.relaunch
      @calabash_launcher.calabash_notify(self)
    end
  end

  config.before(:each) do
    element_exists('view')
  end

  config.after do
    unless @calabash_launcher.calabash_no_stop?
      calabash_exit
      @calabash_launcher.stop if @calabash_launcher.active?
    end
  end
end