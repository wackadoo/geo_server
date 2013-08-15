# encoding: UTF-8

user = Backend::User.new()
user.login = 'admin'
user.email = 'info@5dlab.com'
user.password = '5dlab5dlab'
user.admin = true
user.staff = true
user.deleted = false
user.save
