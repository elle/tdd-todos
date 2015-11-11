# Steps

## 1. Start a new rails app

```
$ rails new tdd-todos -B --skip-turbolinks -T
$ cd tdd-todos
$ bundle
$ git init
$ git add .
$ git coomit -m "Initial commit"
```

## 2. Add rspec-rails

```
# Gemfile
group :development, :test do
  gem "rspec-rails"
end
```
```
$ bundle
$ rails g
$ rails g rspec:install
$ git diff
```
```ruby
# added .rspec and spec/
# uncommented in spec/spec_helper.rb
config.order = :random
```
```
$ git add .
$ git commit -m "Add Rspec"
```

## 3. Viewing a home page

```
# Gemfile
gem "high_voltage"

group :development, :test do
  gem "capybara"
  gem "launchy"
end
```
```
$ bundle
$ bundle binstubs rspec-core
$ mkdir spec/features
$ touch spec/features/view_homepage_spec.rb
$ ./bin/rspec
```
```ruby
# spec/features/view_homepage_spec.rb
require "rails_helper"

feature "View homepage" do
  scenario "user sees relevant information" do
    visit root_path

    expect(page).to have_title "Todos"
    expect(page).to have_css '[data-role="description"]', text: "Todos"
  end
end
```
```
$ ./bin/rspec
```
```ruby
# config/routes
root to: "high_voltage/pages#show", id: "homepage"
```
```
$ rake routes
$ ./bin/rspec
$ mkdir app/views/pages
$ touch app/views/pages/homepage.html.erb
```
```
# app/views/pages/homepage.html.erb
<p data-role="description">Todos</p>
```
```
$ ./bin/rspec
$ git status
$ git add .
$ git commit -m "Set up homepage"
```

## 4. Users can sign in with email address

```
$ touch spec/features/sign_in_spec.rb
```
```ruby
# spec/features/sign_in_spec.rb
require "rails_helper"

feature "User signs in" do
  scenario "with an email" do
    visit root_path

    fill_in "Email address", with: "joe@example.com"
    click_on "Sign In"

    expect(page).to have_css(".welcome", text: "Welcome joe@example.com")
  end
end
```
```
$ ./bin/rspec
```
```ruby
# app/views/pages/homepage.html.erb
<%= form_for :session, url: session_path do |form| %>
  <%= form.label :email_address %>
  <%= form.text_field :email_address %>
  <%= form.submit 'Sign In' %>
<%- end %>
```
```
$ ./bin/rspec
```
```ruby
# config/routes.rb
resource :session, only: [:create]
```
```
$ ./bin/rspec
$ touch app/controllers/sessions_controller.rb
$ ./bin/rspec
```
```ruby
# app/controllers/sessions_controller.rb
class SessionsController < ApplicationController
end
```
```
$ ./bin/rspec
```
```ruby
# app/controllers/sessions_controller.rb
def create
end
```
```
$ ./bin/rspec
```
```ruby
# app/controllers/sessions_controller.rb
class SessionsController < ApplicationController
  def create
    session[:current_email] = params[:session][:email_address]
    redirect_to root_path
  end
end
```
```
$ ./bin/rspec
```
```ruby
# app/views/layouts/application.html.erb
<%- if session[:current_email] %>
  <p class="welcome">Welcome <%= session[:current_email] %></p>
<%- end %>
```
```
$ ./bin/rspec
$ git status
$ git diff
$ git add .
$ git commit -m "Users can sign in with email address"
```

## 5. Refactor to not interact with session from controller and view

```ruby
# app/controllers/application_controller.rb
private

def sign_in_as(email)
  session[:current_email] = email
end

def current_user
  OpenStruct.new(email: session[:current_email])
end
helper_method :current_user
```
```ruby
# app/controllers/sessions_controller.rb
sign_in_as params[:session][:email_address]
```
```ruby
# app/views/layouts/application.html.erb
<%- if current_user %>
  <p class="welcome">Welcome <%= current_user.email %></p>
```
```
$ ./bin/rspec
$ git add .
$ git commit -m "Refactor to not interact with session from controller and view"
```

## 6. Create form to enter todos
```
$ touch spec/features/manage_todos_spec.rb
```
```ruby
# spec/features/manage_todos_spec.rb
require "rails_helper"

feature "Manage todos" do
  scenario "creates a new todo" do
    visit root_path
    fill_in "Email address", with: "joe@example.com"
    click_on "Sign In"
    click_link "Add a new todo"
    fill_in "Description", with: "Buy milk"
    click_button "Create todo"

    expect(page).to have_css("li.todo", text: "Buy milk")
  end
end
```
```
$ ./bin/rspec
```
```ruby
# config/routes
resources :todos, only: [:index, :new, :create]
```
```
$ ./bin/rspec
$ touch app/controllers/todos_controller.rb
```
```ruby
# app/controllers/todos_controller.rb
class TodosController < ApplicationController
  def index
  end
end
```
```
$ ./bin/rspec
$ mkdir app/views/todos
$ touch app/views/todos/index.html.erb
$ ./bin/rspec
```
```ruby
# app/views/todos/index.html.erb
<%= link_to "Add a new todo", new_todo_path %>
```
```
$ ./bin/rspec
```
```ruby
# app/controllers/todos_controller.rb
class TodosController < ApplicationController
  def index
  end

  def new
  end
end
```
```
$ ./bin/rspec
$ touch app/views/todos/new.html.erb
$ ./bin/rspec
```
```ruby
# app/views/todos/new.html.erb
<%= form_for @todo do |form| %>
  <%= form.label :description %>
  <%= form.text_field :description %>
  <%= form.submit 'Create todo' %>
<%- end %>
```
```
$ ./bin/rspec
$ rails g model todo description
$ rake db:migrate
$ rake db:migrate RAILS_ENV=test
```
```ruby
# app/controllers/todos_controller.rb
def new
  @todo = Todo.new
end
```
```
$ ./bin/rspec
```
```ruby
# app/controllers/todos_controller.rb
class TodosController < ApplicationController
  def index
  end

  def new
    @todo = Todo.new
  end

  def create
    todo = Todo.new(todo_params)
    todo.save
    redirect_to todos_path
  end

  private

  def todo_params
    params[:todo].permit(:description)
  end
end
```
```
$ ./bin/rspec
```
```ruby
# app/controllers/todos_controller.rb
def index
  @todos = Todo.all
end
```
```ruby
# app/views/todos/index.html.erb
<ul>
  <% @todos.each do |todo| %>
    <li class='todo'><%= todo.description %></li>
  <% end %>
</ul>
```
```ruby
$ ./bin/rspec
$ git status
$ git add
$ git commit -m "Create form to enter todo"
```

## 7. Users only see todos they have created themselves

```
$ touch spec/models/user_spec.rb
```
```ruby
# spec/models/user_spec.rb
require "rails_helper"

describe User do
  context "#email" do
    it "returns the email the user was instantiated with" do
      user = User.new("joe@example.com")

      expect(user.email).to eq "joe@example.com"
    end
  end
end
```
```
$ ./bin/rspec
$ touch app/models/user.rb
```
```ruby
# app/models/user.rb
class User
  attr_reader :email

  def initialize(email)
    @email = email
  end
end
```
```
$ ./bin/rspec
```
```ruby
# spec/models/user_spec.rb
context "#todos" do
  it "returns todos whose owner_email match the user's email" do
    todo1 = Todo.create(description: "Buy milk", owner_email: "joe@example.com")
    todo2 = Todo.create(description: "Buy milk", owner_email: "other@example.com")

    user = User.new("joe@example.com")

    expect(user.todos).to eq [todo1]
  end
end
```
```
$ rails g migration add_owner_email_to_todos
```
```ruby
class AddOwnerEmailToTodos < ActiveRecord::Migration
  def change
    add_column :todos, :owner_email, :string
  end
end
```
```
$ rake db:migrate
$ rake db:migrate RAILS_ENV=test
$ ./bin/rspec
```
```ruby
# app/models/user.rb
def todos
end
```
```
$ ./bin/rspec
```
```ruby
# app/models/user.rb
def todos
  Todo.where(owner_email: email)
end
```
```
$ ./bin/rspec
```
```ruby
# spec/models/todo_spec.rb
require 'rails_helper'

describe Todo do
  describe "#user=" do
    it "assigns owner_email from the user" do
      user = User.new("joe@example.com")
      todo = Todo.new
      todo.user = user

      expect(todo.owner_email).to eq "joe@example.com"
    end
  end
end
```
```
$ ./bin/rspec
```
```ruby
# app/models/todo.rb
def user=(user)
  self.owner_email = user.email
end
```
```
$ rspec spec/models/todo_spec.rb
$ ./bin/rspec
```
```ruby
# spec/features/manage_todos_spec.rb
scenario "view only my todos" do
  Todo.create(description: "Buy eggs", owner_email: "not_me@example.com")

  visit root_path
  fill_in "Email address", with: "joe@example.com"
  click_on "Sign In"
  click_link "Add a new todo"
  fill_in 'Description', with: "Buy milk"
  click_button "Create todo"

  expect(page).to have_css("li.todo", text: "Buy milk")
  expect(page).not_to have_css("li.todo", text: "Buy eggs")
end
```
```
$ ./bin/rspec
```
```ruby
# app/controllers/application_controller.rb
def current_user
  User.new(session[:current_email])
end
```
```ruby
# app/controllers/todos_controller.rb
def index
  @todos = current_user.todos
end
  
def create
  todo = Todo.new(todo_params)
  todo.user = current_user
  ...
end
```
```
$ ./bin/rspec
```

## 8. Refactor specs to use SignInHelpers
```
$ mkdir -p spec/support/features
$ touch spec/support/features/sign_in_helpers.rb
```
```ruby
# spec/support/features/sign_in_helpers.rb
module SignInHelpers
  def sign_in_as(email)
    visit root_path

    fill_in "Email address", with: email
    click_button "Sign In"
  end
end
```
```ruby
RSpec.configure do |config|
  config.include SignInHelpers
end
```
```ruby
# spec/rails_helper, uncomment line 23
Dir[Rails.root.join('spec/support/**/*.rb')].each { |f| require f }
```
```
$ ./bin/rspec
```
```ruby
# spec/features/manage_todos_spec.rb
sign_in_as "joe@example.com"
```
```
$ ./bin/rspec
$ git status
$ git add .
$ git commit -m "Refactor specs to use SignInHelpers"
```

## 9. Refactor specs to use factories

```
# Gemfile
gem "factory_girl_rails"
```
```
$ bundle
$ touch spec/support/factory_girl.rb
```
```ruby
# spec/support/factory_girl.rb
RSpec.configure do |config|
  config.include FactoryGirl::Syntax::Methods
end
```
```
$ ./bin/rspec
$ touch spec/factories.rb
```
```ruby
# spec/factories
FactoryGirl.define do
  factory :todo do
    description "Buy milk"
    owner_email "joe@example.com"
  end
end
```
```ruby
# spec/features/manage_todos_spec.rb:14
create(:todo, description: "Buy eggs", owner_email: "not_me@example.com")
```
```ruby
# spec/models/user_spec.rb:16-17
todo1 = create(:todo, owner_email: "joe@example.com")
todo2 = create(:todo, owner_email: "other@example.com")
```
```
$ ./bin/rspec
$ git add .
```

## 10. Introduce DatabaseCleaner
```
# Gemfile
gem "database_cleaner"
```
```
$ bundle
$ touch spec/support/database_cleaner.rb
```
```ruby
# spec/support/database_cleaner.rb
RSpec.configure do |config|
  config.before(:suite) do
    DatabaseCleaner.clean_with :truncation
  end

  config.before(:each) do
    DatabaseCleaner.strategy = :transaction
  end

  config.before(:each, js: true) do
    DatabaseCleaner.strategy = :deletion
  end

  config.before(:each) do
    DatabaseCleaner.start
  end

  config.after(:each) do
    DatabaseCleaner.clean
  end
end
```
```
$ ./bin/rspec
```
```
# spec/models/user_spec.rb
# rm line 14: Todo.delete_all
```
```
$ ./bin/rspec
$ git status
$ git add .
$ git commit -m "Introduce DatabaseCleaner"
```

## 11. Todos can be completed

```ruby
# spec/features/manage_todos_spec.rb
def create_todo_with_description(description)
  click_link "Add a new todo"
  fill_in "Description", with: description
  click_button "Create todo"
end
```
```ruby
# and reuse in the two feature specs
# then add
scenario "mark todos as complete" do
  sign_in_as "joe@example.com"
  create_todo_with_description "Buy some milk"

  within "li.todo" do
    click_link "Complete"
  end

  expect(page).to have_css "li.todo.completed"
end
```
```
$ ./bin/rspec
```
```ruby
# app/views/todos/index.html.erb
<li class="todo">
  <%= todo.description %>
  <%= link_to "Complete", todo_completion_path(todo), method: :post -%>
</li>
```
```
$ ./bin/rspec
```
```ruby
# config/routes.rb
resources :todos, only: [:index, :new, :create] do
  resource :completion, only: [:create]
end
```
```
$ rake routes
$ ./bin/rspec
```
```
$ touch app/controllers/completions_controller.rb
```
```ruby
# app/controllers/completions_controller.rb
class CompletionsController < ApplicationController
  def create
  end
end
```
```
$ ./bin/rspec
$ rails g migration add_completed_at_to_todos
```
```ruby
class AddCompletedAtToTodos < ActiveRecord::Migration
  def change
    add_column :todos, :completed_at, :timestamp
  end
end
```
```
$ rake db:migrate
$ rake db:migrate RAILS_ENV=test
```
```ruby
# app/controllers/completions_controller.rb
class CompletionsController < ApplicationController
  def create
    todo = Todo.find(params[:todo_id])
    todo.touch :completed_at
    redirect_to todos_path
  end
end
```
```
$ ./bin/rspec
```
```ruby
# app/views/todos/index.html.erb:3
<li class="todo <%= 'completed' if todo.completed_at? %>">
```
```
$ ./bin/rspec
$ git status
$ git add .
$ git commit
```
