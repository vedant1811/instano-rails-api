class V1::Visitor < ActiveRecord::Base

  after_create :update

  has_paper_trail
private
  def update
      InstanoMailer.delay.new_visitor(self)
  end
end
