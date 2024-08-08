# frozen_string_literal: true

require 'rails_helper'

describe PostsController, type: :controller do
  describe 'GET #index' do
    let(:user) { create(:user) }
    let!(:posts) { create_list(:post, 3, created_by: user) }
    let!(:other_user_post) { create(:post) }

    context 'unauthenticated' do
      it 'response with unauthorized error' do
        get :index

        expect(response).to have_http_status :unauthorized
      end
    end

    context 'authenticated' do
      before :each do
        sign_in user
      end

      it 'returns all post' do
        get :index

        expect(response).to have_http_status :ok
        expect(JSON.parse(response.body).length).to eq(4)
      end
    end
  end

  describe 'GET #show' do
    let(:user) { create(:user) }
    let!(:post) { create(:post, id: 1) }

    context 'unauthenticated' do
      it 'response with unauthorized error' do
        get :show, params: { id: 1 }

        expect(response).to have_http_status :unauthorized
      end
    end

    context 'authenticated' do
      before :each do
        sign_in user
      end

      it 'response with not found when post id not found' do
        get :show, params: { id: 22 }

        expect(response).to have_http_status :not_found
      end

      it 'return post' do
        get :show, params: { id: 1 }

        expect(response).to have_http_status :ok

        parsed_response = JSON.parse(response.body)

        expect(parsed_response['id']).to eq(post.id)
        expect(parsed_response['text']).to eq(post.text)
      end
    end
  end

  describe 'POST #create' do
    let(:user) { create(:user) }

    context 'unauthenticated' do
      it 'response with unauthorized error' do
        post :create, params: { post: { text: 'this is text' } }

        expect(response).to have_http_status :unauthorized
      end
    end

    context 'authenticated' do
      before :each do
        sign_in user
      end

      it 'response with bad request when not has post in params' do
        post :create, params: {}

        expect(response).to have_http_status :bad_request
      end

      it 'response with unprocessable entity when not text invalid' do
        post :create, params: { post: { text: { text: '' } } }

        expect(response).to have_http_status :unprocessable_entity
      end

      it 'create post with valid params' do
        text = 'post text2'
        post :create, params: { post: { text: } }

        expect(response).to have_http_status :ok

        post = Post.where(text:).first
        expect(post).to be_present
      end

      it 'set created by to current user' do
        text = 'post text'
        delete :create, params: { post: { text: } }

        post = Post.where(text:).first
        expect(post.created_by_id).to eq(user.id)
      end
    end
  end

  describe 'PUT #update' do
    let(:user) { create(:user) }
    let!(:post) { create(:post, id: 1, created_by: user) }
    let!(:other_user_post) { create(:post, id: 2) }

    context 'unauthenticated' do
      it 'response with unauthorized error' do
        put :update, params: { id: 1, post: { text: 'this is text' } }

        expect(response).to have_http_status :unauthorized
      end
    end

    context 'authenticated' do
      before :each do
        sign_in user
      end

      it 'response with not found when post id not found' do
        put :update, params: { id: 22, post: { text: 'this is text' } }

        expect(response).to have_http_status :not_found
      end

      it 'response with forbidden when not post owner' do
        put :update, params: { id: 2, post: { text: 'this is text' } }

        expect(response).to have_http_status :forbidden
      end

      it 'resposne with bad request when has no post in params' do
        put :update, params: { id: 1 }

        expect(response).to have_http_status :bad_request
      end

      it 'response with unprocessable entity when params invalid' do
        put :update, params: { id: 1, post: { text: '' } }

        expect(response).to have_http_status :unprocessable_entity
      end

      it 'update post with valid params' do
        text = 'updated text'
        put :update, params: { id: 1, post: { text: } }

        post = Post.where(text:).first
        expect(post).to be_present
      end
    end
  end

  describe 'DELETE #destroy' do
    let(:user) { create(:user) }
    let!(:post) { create(:post, id: 1, created_by: user) }
    let!(:other_user_post) { create(:post, id: 2) }

    context 'unauthenticated' do
      it 'response with unauthorized error' do
        delete :destroy, params: { id: 1 }

        expect(response).to have_http_status :unauthorized
      end
    end

    context 'authenticated' do
      before :each do
        sign_in user
      end

      it 'response not found when post id not found' do
        delete :destroy, params: { id: 22 }

        expect(response).to have_http_status :not_found
      end

      it 'response forbidden when not post owner' do
        delete :destroy, params: { id: 2 }

        expect(response).to have_http_status :forbidden
      end

      it 'delete post' do
        delete :destroy, params: { id: 1 }

        expect(response).to have_http_status :ok

        post = Post.where(id: 1).first
        expect(post).not_to be_present
      end
    end
  end
end
