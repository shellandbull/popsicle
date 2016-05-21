 ![](http://icons.iconarchive.com/icons/mad-science/food-on-a-stick/16/popsicle-icon.png)  ![](http://icons.iconarchive.com/icons/mad-science/food-on-a-stick/16/popsicle-icon.png)  ![](http://icons.iconarchive.com/icons/mad-science/food-on-a-stick/16/popsicle-icon.png)  ![](http://icons.iconarchive.com/icons/mad-science/food-on-a-stick/16/popsicle-icon.png)  ![](http://icons.iconarchive.com/icons/mad-science/food-on-a-stick/16/popsicle-icon.png)  ![](http://icons.iconarchive.com/icons/mad-science/food-on-a-stick/16/popsicle-icon.png)
 ![](http://icons.iconarchive.com/icons/mad-science/food-on-a-stick/16/popsicle-icon.png)
 ![](http://icons.iconarchive.com/icons/mad-science/food-on-a-stick/16/popsicle-icon.png)
 ![](http://icons.iconarchive.com/icons/mad-science/food-on-a-stick/16/popsicle-icon.png)
 ![](http://icons.iconarchive.com/icons/mad-science/food-on-a-stick/16/popsicle-icon.png)
 ![](http://icons.iconarchive.com/icons/mad-science/food-on-a-stick/16/popsicle-icon.png)
 ![](http://icons.iconarchive.com/icons/mad-science/food-on-a-stick/16/popsicle-icon.png)
 ![](http://icons.iconarchive.com/icons/mad-science/food-on-a-stick/16/popsicle-icon.png)
 ![](http://icons.iconarchive.com/icons/mad-science/food-on-a-stick/16/popsicle-icon.png)
 ![](http://icons.iconarchive.com/icons/mad-science/food-on-a-stick/16/popsicle-icon.png)
 ![](http://icons.iconarchive.com/icons/mad-science/food-on-a-stick/16/popsicle-icon.png)
 ![](http://icons.iconarchive.com/icons/mad-science/food-on-a-stick/16/popsicle-icon.png)
 ![](http://icons.iconarchive.com/icons/mad-science/food-on-a-stick/16/popsicle-icon.png)
 ![](http://icons.iconarchive.com/icons/mad-science/food-on-a-stick/16/popsicle-icon.png)
 ![](http://icons.iconarchive.com/icons/mad-science/food-on-a-stick/16/popsicle-icon.png)
 ![](http://icons.iconarchive.com/icons/mad-science/food-on-a-stick/16/popsicle-icon.png)
 ![](http://icons.iconarchive.com/icons/mad-science/food-on-a-stick/16/popsicle-icon.png)
 ![](http://icons.iconarchive.com/icons/mad-science/food-on-a-stick/16/popsicle-icon.png)
 ![](http://icons.iconarchive.com/icons/mad-science/food-on-a-stick/16/popsicle-icon.png)
 ![](http://icons.iconarchive.com/icons/mad-science/food-on-a-stick/16/popsicle-icon.png)

# Popsicle [![Build Status](https://travis-ci.org/mariogintili/popsicle.svg?branch=master)](https://travis-ci.org/mariogintili/popsicle) [![Code Climate](https://codeclimate.com/github/mariogintili/popsicle/badges/gpa.svg)](https://codeclimate.com/github/mariogintili/popsicle) [![Deploy](https://www.herokucdn.com/deploy/button.svg)](https://heroku.com/deploy)

A tiny Rack app to serve your Ember-CLI apps. Since it's rack-based you can easily mount this on any other framework and enjoy the fun!

# Setup

- Press the deploy to Heroku button :rocket:
- Assign the env vars specified on [`app.json`](https://github.com/mariogintili/popsicle/blob/master/app.json) OR add a custom initializer, like the one specified at the bottom of the file
- Deploy your Ember-CLI application & enjoy.

# Usage with Rails

Since this is a Rack-based application you can [mount it as middleware](http://guides.rubyonrails.org/rails_on_rack.html#configuring-middleware-stack) and setup some redirect rules on top ensuring Popsicle will only be on the set of routes that best suit you.

Don't forget to add an initializer, i.e `config/popsicle.rb`

```ruby
Popsicle::Application do |config|
  config.app_name = "name-of-my-js-app"
end
```
