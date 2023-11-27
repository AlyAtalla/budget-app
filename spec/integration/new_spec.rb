require 'rails_helper'

RSpec.describe 'categories/new.html.erb', type: :view do
  before do
    assign(:category, Category.new)
    render
  end
end
