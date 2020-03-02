# Flame Flash

[Flashes](http://guides.rubyonrails.org/action_controller_overview.html#the-flash)
for [Flame](https://github.com/AlexWayfer/flame).

[![Cirrus CI - Base Branch Build Status](https://img.shields.io/cirrus/github/AlexWayfer/flame-flash?style=flat-square)](https://cirrus-ci.com/github/AlexWayfer/flame-flash)
[![Codecov branch](https://img.shields.io/codecov/c/github/AlexWayfer/flame-flash/master.svg?style=flat-square)](https://codecov.io/gh/AlexWayfer/flame-flash)
[![Code Climate](https://img.shields.io/codeclimate/maintainability/AlexWayfer/flame-flash.svg?style=flat-square)](https://codeclimate.com/github/AlexWayfer/flame-flash)
![Depfu](https://img.shields.io/depfu/AlexWayfer/flame-flash?style=flat-square)
[![Inline docs](https://inch-ci.org/github/AlexWayfer/flame-flash.svg?branch=master)](https://inch-ci.org/github/AlexWayfer/flame-flash)
[![license](https://img.shields.io/github/license/AlexWayfer/flame-flash.svg?style=flat-square)](https://github.com/AlexWayfer/flame-flash/blob/master/LICENSE)
[![Gem](https://img.shields.io/gem/v/flame-flash.svg?style=flat-square)](https://rubygems.org/gems/flame-flash)

## Using

```ruby
# Gemfile
gem 'flame-flash'

# config.ru
require 'flame-flash' # or `Bundler.require`

# _controller.rb
include Flame::Flash
```

```erb
<!-- layout.html.erb -->

<%
  %i[error warning notice].each do |type|
    flash[type].each do |text|
%>
      <p class="flash <%= type %>">
        <%= text %>
      </p>
<%
    end
  end
%>
```

## Examples

```ruby
class PostsController < Flame::Controller
  def update
    flash[:error] = "You don't have permissions"
    redirect :show
  end

  def delete
    redirect :show, notice: 'Deleted'
  end

  def move
    redirect :index, flash: { success: 'Moved' }
  end

  def create
    flash.now[:error] = 'Not enought permissions'
    view :new
  end
end
```

### Reserved keys

*   `error`
*   `warning`
*   `notice`
