Factory.define :user do |user|
  user.username 'username'
  user.password 'password'
  user.password_confirmation 'password'
end

Factory.define :link do |link|
  link.title 'Carbon Five'
  link.url 'http://www.carbonfive.com'
end