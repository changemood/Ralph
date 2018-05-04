json.array! @review_cards do |card|
  json.partial! 'card', card: card
  # sr_events.first returns latest event record for the card...
  # since we have default scope for sr_event which is created_at: :desc
  json.sr_event_id card.sr_events.first.id
  json.extract! card.sr_events.first, :interval, :review_count, :next_review_at, :reviewed_at
end
