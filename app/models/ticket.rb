class Ticket < ApplicationRecord
  self.per_page = 15

  # == Constants ===================================

  # == Associations ================================
  belongs_to :agent, class_name: 'User'

  has_attached_file :image,
  styles: { medium: "300x300>", thumb: "100x100>"},
  content_type: { content_type: ["image/jpeg", "image/png"] }

  # == Validations ==================================================
  validates_attachment :image, content_type: { content_type: ["image/jpg", "image/jpeg", "image/png", "image/gif"] }

  # == Interface ===================================
  # == Constants ===================================
  # == Validations =================================
  validates :title, presence: true
  validates :description, presence: true

  def self.statuses_for_select
    ['OPEN', 'IN-PROGRESS', 'SOLVED']
  end

  def ref_number
    "00#{id}"
  end
end