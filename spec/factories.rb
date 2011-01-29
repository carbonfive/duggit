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
  link.association :author, :factory => :user
end

Factory.define :vote do |vote|
  vote.value 0
  vote.association :user, :factory => :user
  vote.association :link, :factory => :link
end
