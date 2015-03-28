class V1::Visitor < ActiveRecord::Base
  include AdminNotifiable

  has_paper_trail
end
