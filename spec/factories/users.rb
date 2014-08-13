# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :user do
    email "example@example.com"
    password "example123"
    password_confirmation "example123"  
    first_name "Javier"
    last_name "Gradiche"
    autoconfirm false
    factory :user_autoconfirm do
      autoconfirm true
    end
  end
end
