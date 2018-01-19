require 'paperclip/matchers'

RSpec.configure do |config|
  config.after(:suite) do
    FileUtils.rm_rf(Dir["#{Rails.root}/spec/test_files/"])
  end
  config.include Paperclip::Shoulda::Matchers
end