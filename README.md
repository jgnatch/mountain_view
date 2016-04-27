![Mountain View](https://cloud.githubusercontent.com/assets/623766/7324123/e4f4a9fe-ea89-11e4-97cd-006314593252.png)


[![Build Status](https://travis-ci.org/devnacho/mountain_view.svg?branch=master)](https://travis-ci.org/devnacho/mountain_view)
[![Code Climate](https://codeclimate.com/github/devnacho/mountain_view/badges/gpa.svg)](https://codeclimate.com/github/devnacho/mountain_view)

With Mountain View you create reusable components for your Rails frontend, while generating a living style guide.

_FAQ_: Does it generate it automatically? You bet!

#### Example Style Guide

Visit the **<a href="https://mountain-view.herokuapp.com/mountain_view/styleguide" target="_blank">living style guide demo!</a>**
(<a href="https://github.com/devnacho/mountain_view_demo" target="_blank">source repo</a>)

<a href="https://mountain-view.herokuapp.com" target="_blank">Usage of components demo here!</a>


## Installation

Add this line to your application's Gemfile:

    gem 'mountain_view'

Then execute:

    $ bundle

Mountain View supports Ruby 2.0+.

## Usage

Use the built-in generator to create a new component:

```
rails generate mountain_view:component header
```

This will create the following directory structure:

```
app/
  components/
    header/
      _header.html.erb
      header.css
      header.js
      header.yml
      header_component.rb # optional
```

Keep in mind that you can also use `scss`, `coffeescript`, `haml`, or any other
preprocessors that your app is currently using.


### Component Example
You can write your own templates on erb, haml or any other templating language.
Same goes with stylesheets and javascripts. You can use scss, sass or
coffee-script as long as you have these preprocessors running on your app.

```erb
<!-- app/components/header/_header.html.erb -->
<div class="header">
  <h1>This is a header component with the title: <%= title %></h1>
  <h3>And subtitle <%= subtitle %></h3>
  <% if show_links? %>
    <ul>
      <% links.each do |link| %>
        <li><%= link %></li>
      <% end %>
    </ul>
  <% end %>
</div>
```

```ruby
# app/components/header/header_component.rb
class HeaderComponent < MountainView::Presenter
  properties :title, :subtitle
  property :links, default: []

  def title
    properties[:title].titleize
  end

  def show_links?
    links.any?
  end
end
```

Including a component class is optional, but it helps avoid polluting your
views and helpers with presenter logic. Public methods in your component class
will be made available to the view, along with any properties you define. 
You can also access all properties using the `properties` method in your 
component class and views. You can even define property defaults.

### Using components on your views
You can then call your components on any view by using the following
helper:

```erb
<%= render_component "header", title: "This is a title", subtitle: "And this is a subtitle" %>
```

### Assets
You can require all the components CSS and JS automatically by requiring `mountain_view` in your main JS and CSS files.

### Global Stylesheets
In case you want to add global stylesheets (e.g. colors.scss, fonts.scss, etc.) to your Mountain View components you can do it by calling them with an initializer

```ruby
#config/initializers/mountain_view.rb

MountainView.configure do |config|
  config.included_stylesheets = ["colors", "fonts"]
end

```

```
//= require mountain_view
```

## Automatically generated Style Guide
A style guide will be automatically generated. This style guide never falls behind and it reflects your components in their latest version.

#### Setting up the style guide
1) Add the following line to your `routes.rb` file.
```ruby
mount MountainView::Engine => "/mountain_view"
```
2) Create stubs for your components. These stubs will be the examples in the style guide.

E.g: `app/components/card/card.yml`
```yml
-
  :title: "Aspen Snowmass"
  :description: "Aspen Snowmass is a winter resort complex located in Pitkin County in western Colorado in the United States. Owned and operated by the Aspen Skiing Company it comprises four skiing/snowboarding areas on four adjacent mountains in the vicinity of the towns of Aspen and Snowmass Village."
  :link: "http://google.com"
  :image_url: "http://i.imgur.com/QzuIJTo.jpg"
  :data:
  -
    :title: "Elevation"
    :number: '7879ft'
  -
    :title: "Depth"
    :number: '71"'
-
  :title: "Sunset on the Mountain"
  :description: "Three major ranges of the Alps – the Northern Calcareous Alps, Central Alps, and Southern Calcareous Alps – run west to east through Austria. The Central Alps, which consist largely of a granite base, are the largest and highest ranges in Austria."
  :link: "http://google.com"

```

If your component depends on a form builder object you can use the following statement:

```yml
:meta: 'There is a class with form builder object'
:stubs:
  -
    :form:
      !ruby/object:MountainView::Helpers::FormBuilder
        model: !ruby/object:Something
          attributes:
            name: 'something name'
```

Also you can stub any ruby class with the following method:


```yml
:meta: 'There is a class with an AR object'
:stubs:
  -
    :some_model: !ruby/object:Something
      attributes:
        name: 'blabla'
```

For any complex logic you can define a custom Compoenent Stub with `init_with(coder)` method which will receive a `#map` with attributes loaded from yaml file:

```yml
:meta: 'There is a class with a complex logic'
:stubs:
  -
    :some_model: !ruby/object:ComponentStub
      params:
        - 'blabla'
        - 'nothing'
      name: 'Some Name'
```

```ruby
class ComponentStub < SomeModel # SomeModel could be AR class
  def init_with(coder)
    param1 = coder.map["params"].first
    somename = coder.map["name"]
    # or `@properties = coder.map`
    initialize(param1, somename) # call initializer of SomeModel
  end
end
```

3) Vist `http://localhost:3000/mountain_view/styleguide`

#### Example Style Guide

Visit the **<a href="https://mountain-view.herokuapp.com/mountain_view/styleguide" target="_blank">living style guide demo!</a>**
(<a href="https://github.com/devnacho/mountain_view_demo" target="_blank">source repo</a>)

<a href="https://mountain-view.herokuapp.com" target="_blank">Usage of components demo here!</a>

![mountain_view](https://cloud.githubusercontent.com/assets/623766/7099771/5b06d8da-dfd4-11e4-8558-1b7f026f28ad.gif)

## Contributing

See the [contributing guide](./CONTRIBUTING.md).

## Team

### Current Maintainers

* [Esteban Pastorino](https://github.com/kitop)
* [Ignacio Gutierrez](https://github.com/devnacho)

## Credits
This library was inspired by [Rizzo](http://rizzo.lonelyplanet.com/styleguide/ui-components/cards), a wonderful living style guide created by the guys at LonelyPlanet. [More info here](http://engineering.lonelyplanet.com/2014/05/18/a-maintainable-styleguide.html)
