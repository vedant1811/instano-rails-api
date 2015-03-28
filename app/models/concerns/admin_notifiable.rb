module AdminNotifiable
  extend ActiveSupport::Concern

  included do
    after_save { InstanoMailer.notification(self).deliver_later }
  end
end
