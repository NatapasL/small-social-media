# frozen_string_literal: true

require 'rails_helper'

describe Post, type: :model do
  let(:user) { build(:user) }

  context 'validation' do
    it 'valid with valid attributes' do
      post = Post.new(text: 'test text', created_by: user)
      expect(post).to be_valid
    end

    it 'invalid withou text' do
      post = Post.new(created_by: user)
      expect(post).not_to be_valid
    end

    it 'invalid with text longer than 100 characters' do
      post = Post.new(text: 'a' * 101, created_by: user)
      expect(post).not_to be_valid
    end

    it 'invalid without created by' do
      post = Post.new(created_by: user)
      expect(post).not_to be_valid
    end
  end
end
