# frozen_string_literal: true

class CreateMeetingDurations < ActiveRecord::Migration[6.1]
  def change
    create_table :meeting_durations do |t|
      t.references :survey_response, null: false, foriegn_key: true
      t.datetime :started_at
      t.integer :minutes

      t.timestamps
    end
  end
end
