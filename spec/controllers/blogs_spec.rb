require 'rails_helper'

describe BlogsController do
  describe 'GET #index' do
    it "@blogsに全てのBlogが入っていること" do
      @blogs = create_list(:blog, 3)
      get :index
      expect(assigns(:blogs)).to eq @blogs
    end
  end

  describe 'POST #create' do
    it "新規作成後に@blogのshowに遷移すること" do
      post :create, params: { blog: attributes_for(:blog) }
      expect(response).to redirect_to assigns(:blog)
    end
  end
end
