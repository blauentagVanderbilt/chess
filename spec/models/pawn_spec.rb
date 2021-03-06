require 'rails_helper'

RSpec.describe Pawn, type: :model do
  describe "#valid move?" do 
    #--- Opening Move ----#
    
    it "should return true to move one square forward on first move" do
      game = Game.create
      pawn = FactoryBot.create :pawn, x_position: 2, y_position: 2, game_id: game.id, color: "white"
      expect(pawn.valid_move?(2, 3)).to eq(true)
    end

    it "should return true to move two squares forward on first move" do
      game = Game.create
      pawn = FactoryBot.create :pawn, x_position: 2, y_position: 7, game_id: game.id, color: "black"
      expect(pawn.valid_move?(2, 5)).to eq(true)
    end

    it "should return false to move three squares forward on first move" do
      game = Game.create
      pawn = FactoryBot.create :pawn, x_position: 2, y_position: 2, game_id: game.id, color: "white"
      expect(pawn.valid_move?(2, 5)).to eq(false)
    end

    it "should return false to move one square sideways on first move" do
      game = Game.create
      pawn = FactoryBot.create :pawn, x_position: 2, y_position: 2, game_id: game.id, color: "white"
      expect(pawn.valid_move?(3, 2)).to eq(false)
    end

    #--- Subsequent Moves ---#

    it "should return true for white pawn to move one square forward" do
      game = Game.create
      pawn = FactoryBot.create :pawn, x_position: 5, y_position: 5, game_id: game.id, color: "white"
      expect(pawn.valid_move?(5, 6)).to eq(true)
    end

    it "should return true for black pawn to move one square forward" do
      game = Game.create
      pawn = FactoryBot.create :pawn, x_position: 5, y_position: 5, game_id: game.id, color: "black"
      expect(pawn.valid_move?(5, 4)).to eq(true)
    end

    it "should return false for white pawn to move backward" do
      game = Game.create
      pawn = FactoryBot.create :pawn, x_position: 5, y_position: 5, game_id: game.id, color: "white"
      expect(pawn.valid_move?(5, 4)).to eq(false)
    end

    it "should return false for black pawn to move backward" do
      game = Game.create
      pawn = FactoryBot.create :pawn, x_position: 2, y_position: 2, game_id: game.id, color: "black"
      expect(pawn.valid_move?(5, 6)).to eq(false)
    end

    it "should return false to move two squares forward" do
      game = Game.create
      pawn = FactoryBot.create :pawn, x_position: 2, y_position: 2, game_id: game.id, color: "white"
      expect(pawn.valid_move?(5, 7)).to eq(false)
    end

    it "should return false to move one square sideways" do
      game = Game.create
      pawn = FactoryBot.create :pawn, x_position: 5, y_position: 2, game_id: game.id, color: "white"
      expect(pawn.valid_move?(6, 2)).to eq(false)
    end
  
#----- En Passant ------#
    
    it "should return true for black pawn to capture white pawn en passant" do
      game = Game.create
      black_pawn = FactoryBot.create :pawn, x_position: 2, y_position: 5, game_id: game.id, color: "black"
      white_pawn = FactoryBot.create :pawn, x_position: 1, y_position: 5, game_id: game.id, color: "white", move_number: 1
      expect(black_pawn.en_passant?(1, 6)).to eq(true)
    end

    it "should return false for black pawn to capture white pawn en passant if not white's first move" do
      game = Game.create
      black_pawn = FactoryBot.create :pawn, x_position: 2, y_position: 5, game_id: game.id, color: "black"
      white_pawn = FactoryBot.create :pawn, x_position: 1, y_position: 5, game_id: game.id, color: "white", move_number: 2
      expect(black_pawn.en_passant?(1, 6)).to eq(false)
    end

    it "should return false when white pawn is not in valid position" do
      game = Game.create
      black_pawn = FactoryBot.create :pawn, x_position: 2, y_position: 5, game_id: game.id, color: "black"
      white_pawn = FactoryBot.create :pawn, x_position: 4, y_position: 5, game_id: game.id, color: "white", move_number: 1
      expect(black_pawn.en_passant?(1, 6)).to eq(false)
    end

    it "should return false for black pawn to capture white rook en passant" do
      game = Game.create
      black_pawn = FactoryBot.create :pawn, x_position: 2, y_position: 5, game_id: game.id, color: "black"
      white_rook = FactoryBot.create :rook, x_position: 1, y_position: 5, game_id: game.id, color: "white", move_number: 1
      expect(black_pawn.en_passant?(1, 6)).to eq(false)
    end

  end

end




  