class Purchase < ActiveRecord::Base
  belongs_to :user
  belongs_to :project
  belongs_to :share

  validate :available_shares

  def available_shares
    project = Project.find(self.project_id)
    share_want = Share.find(self.share_id)
    num_shares_want = self.number_of_shares
    max_shares_available_from_project = project.max_shares
    all_purchases = project.purchases
    total = 0
    all_purchases.each do |purchase|
        total += purchase.number_of_shares
    end

    if (total + num_shares_want) > max_shares_available_from_project
      errors.add(:number_of_shares, "not available. Try a smaller number.")
    end
  end
end
