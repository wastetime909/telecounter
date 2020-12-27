class AddNewEntranceJob < ApplicationJob 
    queue_as :default

    def perform(id, current_count)
        ActionCable.server.broadcast("progress_#{id}", current_count)
    end
end 