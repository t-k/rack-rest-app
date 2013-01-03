FactoryGirl.define do

  factory :post do
    sequence(:content) { |n| "post-#{n}" }
  end

end