module Api
  module V1
    class CardSerializer < ActiveModel::Serializer
      attributes :id, :title, :body, :created_at, :updated_at, :ancestry, :latest_sr_event
    end
  end
end