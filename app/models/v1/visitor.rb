class V1::Visitor < ActiveRecord::Base

  after_create :update

private
  def update
      InstanoMailer.delay.new_visitor(self)
  end
end
