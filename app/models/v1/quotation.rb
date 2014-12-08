class V1::Quotation < ActiveRecord::Base
  enum status: [ :unread, :read, :expired, :accepted ]
end
