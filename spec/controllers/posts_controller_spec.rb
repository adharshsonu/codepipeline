require 'rails_helper'

RSpec.describe PostsController, type: :controller do
  login_user

  before(:each, create_post: true) { @post = create(:post) }

  describe 'GET #index' do
    context 'valid params - pagination with 10 per page' do
      before(:each) { create_list(:post, 25) }

      after(:each) { render_template :show }

      it 'returns http success' do
        get :index

        expect(response).to have_http_status(:success)
      end

      it 'lists first page count of posts' do
        get :index

        expect(assigns[:posts].length).to eq(10)
      end

      it 'lists second page count of posts' do
        get :index, params: { page: 2 }

        expect(assigns[:posts].length).to eq(10)
      end

      it 'lists third page count of posts' do
        get :index, params: { page: 3 }

        expect(assigns[:posts].length).to eq(5)
      end
    end
  end

  describe 'GET #show' do
    context 'with valid params' do
      before(:each) { @post = create(:post) }

      after(:each) { render_template :show }

      it 'should return http status success' do
        get :show, params: { id: @post.id }

        expect(response).to have_http_status(200)
      end

      it 'should respond with requested post' do
        get :show, params: { id: @post.id }

        expect(assigns[:post]).to eq(@post)
      end
    end
  end

  describe 'POST #create' do
    context 'with invalid params' do
      it 'should return 200 - missing content' do
        post :create, params: { post: { content: '' } }, format: :js

        expect(response).to have_http_status(200)
        expect(assigns[:post].errors.full_messages[0]).to eq("Content can't be blank")
      end
    end

    context 'with valid params' do
      it 'should change post count by 1' do
        expect do
          post :create, params: { post: { content: 'Testing' } }, format: :js
        end.to change(Post, :count).by(1)
      end

      it 'return success response' do
        post :create, params: { post: { content: 'Testing' } }, format: :js

        expect(response).to have_http_status(200)
        expect(flash[:notice]).to eql 'Post was successfully created.'
      end
    end
  end

  describe 'PATCH #update' do
    context 'with invalid params', create_post: true do
      it 'should return 200 - missing content' do
        patch :update, params: { id: @post.id, post: { content: '' } }, format: :js

        expect(response).to have_http_status(200)
        expect(assigns[:post].errors.full_messages[0]).to eq("Content can't be blank")
      end
    end

    context 'with valid params', create_post: true do
      it 'should return http status success' do
        patch :update, params: { id: @post.id, post: { content: 'Testing1' } }, format: :js

        expect(response).to have_http_status(200)
        expect(flash[:notice]).to eql 'Post was successfully updated.'
      end
    end
  end

  describe 'DELETE #destroy' do
    context 'with valid params' do
      it 'should return 200 - change the posts count', create_post: true do
        expect do
          delete :destroy, params: { id: @post.id }
        end.to change(Post, :count).by(-1)
      end

      it 'should return http status - 302', create_post: true do
        delete :destroy, params: { id: @post.id }

        expect(response).to have_http_status(302)
        expect(flash[:notice]).to eql 'Post was successfully deleted'
      end
    end
  end
end
