module Api
  module V1
    class CardSerializer < ActiveModel::Serializer
      attributes :id, :title, :body, :created_at, :updated_at, :board_id, :ancestry, :latest_sr_event
    end
  end
end