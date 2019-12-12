require 'rails_helper'

RSpec.describe King, type: :model do

  describe "#vaild move?" do
    it "should return true to move one square foward" do
      user = FactoryBot.create(:user)
      sign_in user
      game = Game.create
      king = FactoryBot.create :king, x_position: 5, y_position: 5, game_id: game.id
      expect(king.valid_move?(6, 5)).to eq(true)
    end

    it "should return true to move one square backward" do
      game = Game.create
      king = FactoryBot.create :king, x_position: 5, y_position: 5, game_id: game.id
      expect(king.valid_move?(5, 4)).to eq(true)
    end

    it "should return true to move one square down" do
      game = Game.create
      king = FactoryBot.create :king, x_position: 5, y_position: 5, game_id: game.id
      expect(king.valid_move?(5, 6)).to eq(true)
    end

    it "should return true to move one square diagonally" do
      game = Game.create
      king = FactoryBot.create :king, x_position: 5, y_position: 5, game_id: game.id
      expect(king.valid_move?(6, 6)).to eq(true)
    end

    it "should return false to move two squares foward" do
      game = Game.create
      king = FactoryBot.create :king, x_position: 5, y_position: 5, game_id: game.id
      expect(king.valid_move?(7, 5)).to eq(false)
    end
  end
  
end