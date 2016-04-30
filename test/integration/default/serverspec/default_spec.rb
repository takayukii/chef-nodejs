require 'spec_helper'

describe command('node -v | grep v4.3.2') do
  its(:exit_status) { should eq 0 }
end

describe command('npm -v | grep 3.3.12') do
  its(:exit_status) { should eq 0 }
end
