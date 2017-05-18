require 'sidekiq'

module DelayedPaperclip
  class ProcessJob
  	include Sidekiq::Worker

    def self.enqueue_delayed_paperclip(instance_klass, instance_id, attachment_name)
      ::ProcessJob.perform_async(instance_klass, instance_id, attachment_name.to_s)
    end

    def perform(instance_klass, instance_id, attachment_name)
      DelayedPaperclip.process_job(instance_klass, instance_id, attachment_name.to_sym)
    end
  end
end
