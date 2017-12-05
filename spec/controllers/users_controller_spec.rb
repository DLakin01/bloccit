require 'rails_helper'
include SessionsHelper

RSpec.describe UsersController, type: :controller do
  render_views

  let(:new_user_attributes) do
    {
      name: "BlocHead",
      email: "blochead@bloc.io",
      password: "blochead",
      password_confirmation: "blochead"
    }
  end

  describe "GET new" do
    it "returns http success" do
      get :new
      expect(response).to have_http_status(:success)
    end

    it "instantiates a new user" do
      get :new
      expect(assigns(:user)).to_not be_nil
    end
  end

  describe "POST create" do
    it "returns an http redirect" do
      post :create, params: { user: new_user_attributes }
      expect(response).to have_http_status(:redirect)
    end

    it "creates a new user" do
      expect{
        post :create, params: { user: new_user_attributes }
      }.to change(User, :count).by(1)
    end

    it "sets user details properly" do
      post :create, params: { user: new_user_attributes }
      expect(assigns(:user).name).to eq new_user_attributes[:name]
      expect(assigns(:user).email).to eq new_user_attributes[:email]
      expect(assigns(:user).password).to eq new_user_attributes[:password]
      expect(assigns(:user).password_confirmation).to eq new_user_attributes[:password_confirmation]
    end

    it "logs the user in after sign up" do
      post :create, params: { user: new_user_attributes }
      expect(session[:user_id]).to eq assigns(:user).id
    end
  end

  describe "GET show" do
    let(:user) { create(:user) }
    let(:other_user) { create(:user) }
    let(:topic) { create(:topic) }
    let(:post) { create(:post, topic: topic, user: user) }
    let(:user_post) {create(:post, topic: topic, user: other_user)}
    let(:favorite) { Favorite.create!(id: user_post.id) }

    before do
      create_session(user)
    end

    it "returns http success" do
      get :show, params: {id: user.id}
      expect(response).to have_http_status(:success)
    end

    it "renders the show view" do
      get :show, params: {id: user.id}
      expect(response).to render_template :show
    end

    it "assigns factory_user to @user" do
      get :show, params: {id: user.id}
      expect(assigns(:user)).to eq(user)
    end

    it "renders the favorited posts partial" do
      get :show, params: {id: user.id}
      expect(response).to render_template(:partial => "_post")
    end

    it "pulls the correct gravatars" do

    end
  end
end
