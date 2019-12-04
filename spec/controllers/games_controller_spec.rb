require 'rails_helper'

RSpec.describe GamesController, type: :controller do
  describe "grams#index action" do
    it "should successfully show the page" do
      get :index
      expect(response).to have_http_status(:success)
    end
  end

  describe "games#new action" do
    it "should require users to be logged in" do
      get :new
      expect(response).to redirect_to new_user_session_path
    end
    it "should successfully show the new form" do
      user= FactoryBot.create(:user)
      sign_in user
      get :new
      expect(response).to have_http_status(:success)
    end
  end

  describe "games#create action" do
    it "should require a logged in user" do
      post :create, params: {
        game: {
          name: 'Test'
        }
      }
      expect(response).to redirect_to new_user_session_path
    end

    it "should successfully create a new game in our database" do
      user = FactoryBot.create(:user)
      sign_in user
      post :create, params: {
        game: {
          name: 'Death Match'
        }
      }
      expect(response).to redirect_to root_path
      game = Game.last
      expect(game.name).to eq("Death Match")
      expect(game.white_player_id).to eq(user.id)
    end
  end

end
