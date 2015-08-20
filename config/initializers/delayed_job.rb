# pirated from http://stackoverflow.com/questions/4035582/debugging-delayed-jobs

# Optional but recommended for less future surprises.
# Fail at startup if method does not exist instead of later in a background job
[[ExceptionNotifier::Notifier, :background_exception_notification]].each do |object, method_name|
  raise NoMethodError, "undefined method `#{method_name}' for #{object.inspect}" unless object.respond_to?(method_name, true)
end

# Chain delayed job's handle_failed_job method to do exception notification
Delayed::Worker.class_eval do
  def handle_failed_job_with_notification(job, error)
    handle_failed_job_without_notification(job, error)
    # rescue if ExceptionNotifier fails for some reason
    begin
      ExceptionNotifier.notify_exception(error)
    rescue Exception => e
      Rails.logger.error "ExceptionNotifier failed: #{e.class.name}: #{e.message}"
      e.backtrace.each do |f|
        Rails.logger.error "  #{f}"
      end
      Rails.logger.flush
    end
  end
  alias_method_chain :handle_failed_job, :notification
end
Delayed::Worker.destroy_failed_jobs = false
Delayed::Worker.logger = Logger.new(File.join(Rails.root, 'log', 'delayed_job.log'))
Delayed::Worker.max_attempts = 3
Delayed::Worker.max_run_time = 5.minutes
