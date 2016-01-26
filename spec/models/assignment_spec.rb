require 'rails_helper'

RSpec.describe Assignment, type: :model do

  it 'fails validation with  no name' do
  	expect(Assignment.new).to be_invalid
  end

  it 'success validation with name' do
  	expect(Assignment.new(title: 'test')).to be_valid
  end
end
