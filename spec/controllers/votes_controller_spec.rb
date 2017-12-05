require 'rails_helper'
include SessionsHelper

RSpec.describe VotesController, type: :controller do
  let(:my_topic) { create(:topic) }
  let(:my_user) { create(:user) }
  let(:other_user) { create(:user) }
  let(:user_post) { create(:post, topic: my_topic, user: my_user) }
  let(:my_vote) { create(:vote, user: my_user, post:  user_post) }

  context "guest" do
    describe "POST up_vote" do
      it "redirects the user to the sign in view" do
        post :up_vote, params: { post_id: user_post.id }
        expect(response).to redirect_to(new_session_path)
      end
    end

    describe "POST down_vote" do
      it "redirects the user to the sign in view" do
        post :down_vote, params: { post_id: user_post.id }
        expect(response).to redirect_to(new_session_path)
      end
    end
  end

  context "signed in user" do
    before do
      create_session(my_user)
      request.env["HTTP_REFERER"] = topic_post_path(my_topic, user_post)
    end

    describe "POST up_vote" do
      it "increments post votes by one the first time the user votes" do
        votes = user_post.votes.count
        post :up_vote, params: { post_id: user_post.id }
        expect(user_post.votes.count).to eq(votes + 1)
      end

      it "does not increment votes if the user tries to vote again" do
          post :up_vote, params: { post_id: user_post.id }
          votes = user_post.votes.count
          post :up_vote, params: { post_id: user_post.id }
          expect(user_post.votes.count).to eq(votes)
      end

      it "increases the sum of post votes by one" do
        points = user_post.points
        post :up_vote, params: { post_id: user_post.id }
        expect(user_post.points).to eq(points + 1)
      end

      it "back redirects to posts show page" do
        request.env["HTTP_REFERER"] = topic_post_path(my_topic, user_post)
        post :up_vote, params: { post_id: user_post.id }
        expect(response).to redirect_to([my_topic, user_post])
      end

      it "back redirects to topics show page" do
        request.env["HTTP_REFERER"] = topic_path(my_topic)
        post :up_vote, params: { post_id: user_post.id }
        expect(response).to redirect_to(my_topic)
      end
    end

    describe "POST down_vote" do
      it "increments the number of votes by one the first time the user votes" do
        votes = user_post.votes.count
        post :down_vote, params: { post_id: user_post.id }
        expect(user_post.votes.count).to eq(votes + 1)
      end

      it "does not increment votes if the user tries to vote again" do
        post :down_vote, params: { post_id: user_post.id }
        votes = user_post.votes.count
        post :down_vote, params: { post_id: user_post.id }
        expect(user_post.votes.count).to eq(votes)
      end

      it "decreases the sum of post voites by 1" do
        points = user_post.points
        post :down_vote, params: { post_id: user_post.id }
        expect(user_post.points).to eq (points - 1)
      end

      it "back redirects to the posts show page" do
        request.env["HTTP_REFERER"] = topic_post_path(my_topic, user_post)
        post :down_vote, params: { post_id: user_post.id }
        expect(response).to redirect_to([my_topic, user_post])
      end

      it "back redirects to the topics show page" do
        request.env["HTTP_REFERER"] = topic_path(my_topic)
        post :down_vote, params: { post_id: user_post.id }
        expect(response).to redirect_to(my_topic)
      end
    end
  end
end
