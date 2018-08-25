class Card < ApplicationRecord
  acts_as_paranoid

  belongs_to :user, required: true
  # Card doesn't have to belong to board.(board_id can be nil)
  belongs_to :board, required: false
  has_many :sr_events, dependent: :destroy
  
  # ancestry is a simpler tree structure and faster in general compared to Closure tree So we decided to use ancestry
  # Please refer to the link below for more info
  # https://www.hilman.io/blog/2015/09/comparing-ancestry-and-closure_tree/
  has_ancestry
  scope :review_cards, -> { joins(:sr_events).merge(SrEvent.need_review) }

  # For now, we hard code intervals here...
  # TODO: maybe user should be able to decide intervals? like each board can have pace...?
  INTERVALS = {
    1 => 4,
    2 => 8,
    3 => 12,
    4 => 24,
    5 => 72
  }

  # When user click 👍, set next review with longer time span
  def up!
    sr_event = self.sr_events.first
    if sr_event && sr_event.next_review_at < Time.now
      sr_event.reviewed!
      self.add_sr_event(sr_event.review_count + 1)
    else
      puts "WARNING: this card is not ready to be reviewed"
      puts "WARNING: Either because card doesn't have sr_event or need to wait to next_review_at"
    end
  end
  # When user click 👎, set next review with same time span
  def down!
    sr_event = self.sr_events.first
    if sr_event && sr_event.next_review_at < Time.now
      sr_event.reviewed!
      self.add_sr_event(sr_event.review_count)
    else
      puts "WARNING: this card is not ready to be reviewed"
      puts "WARNING: Either because card doesn't have sr_event or need to wait to next_review_at"
    end
  end

  # insert sr_event record
  # TODO: need to consider how we set next_review_at
  # for now we set interval for 4 hours
  # e.g. first interval is 4. from next time, it will be 8, 12, 16...
  # OR we can let user decide. or we never change interval, and user change when they want to.
  def add_sr_event(review_count)
    interval = (review_count > 5) ? 72 : INTERVALS[review_count]
    next_review_at = Time.now + interval.hours
    self.sr_events.create!(interval: interval, review_count: review_count, next_review_at: next_review_at, user_id: self.user_id)
  end

  # To show sortable tree card json we need to follow their format
  # e.g. [{title: "Chicken",expanded: true,children: [{ title: "Egg", children: [{ title: "test" }]] }...]
  def as_sortable_tree_json
    {
      id: self.id,
      title: self.title,
      subtitle: self.body,
      children: self.children.map {|child| child.as_sortable_tree_json}
    }
  end

end
