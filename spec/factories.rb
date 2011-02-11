Factory.sequence :username do |n|
  "username-#{n}"
end

Factory.define :user do |user|
  user.username { Factory.next :username }
  user.password 'password'
  user.password_confirmation 'password'
end

Factory.define(:author, :parent => :user) do |user|
end

Factory.define :link do |link|
  link.title 'Carbon Five'
  link.url 'http://www.carbonfive.com'
  link.association :user, :factory => :user
end

Factory.define :vote do |vote|
  vote.value 1
  vote.user_id { Factory(:user).id }
  vote.link_id { Factory(:link).id }
end

Factory.define(:up_vote, 
               :parent => :vote) do |vote|
  vote.value 1
end

Factory.define(:down_vote, 
               :parent => :vote) do |vote|
  vote.value -1
end
