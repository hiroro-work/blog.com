require 'rails_helper'

describe Blog do
  it "titleがあれば有効な状態であること" do
    expect(Blog.new(title: 'MyBlog').valid?).to be_truthy
  end
  it "titleがなければ無効な状態であること" do
    expect(Blog.new(title: nil).valid?).to be_falsey
  end
end
