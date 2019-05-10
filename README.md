![Mountain View](https://cloud.githubusercontent.com/assets/623766/7324123/e4f4a9fe-ea89-11e4-97cd-006314593252.png)


[![Build Status](https://travis-ci.org/devnacho/mountain_view.svg?branch=master)](https://travis-ci.org/devnacho/mountain_view)
[![Code Climate](https://codeclimate.com/github/jgnatch/mountain_view/badges/gpa.svg)](https://codeclimate.com/github/jgnatch/mountain_view)
[![Reviewed by Hound](https://img.shields.io/badge/Reviewed_by-Hound-8E64B0.svg)](https://houndci.com)


With Mountain View you create reusable components for your Rails frontend, while generating a living style guide.

**FAQ**

_Hey! What is a living style guide?_ A living style guide is a style guide that is always up-to-date and never falls behind.

 _Does it generate it automatically?_ You bet!

#### Example Style Guide

Visit the **<a href="https://mountain-view.herokuapp.com/mountain_view/styleguide" target="_blank">living style guide demo!</a>**
(<a href="https://github.com/devnacho/mountain_view_demo" target="_blank">source repo</a>)

<a href="https://mountain-view.herokuapp.com" target="_blank">Usage of components demo here!</a>


## Installation

Add this line to your application's Gemfile:

    gem 'mountain_view'

Then execute:

    $ bundle

Mountain View supports Ruby 2.2+ and Rails 4.2+ (although it may work in older
versions)

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

### Yielding content

You can also pass a block to a component, for example the following component:

```erb
<!-- app/components/header/_header.html.erb -->
<div class="header">
  <%= properties[:yield] %>
</div>
```

Used in a view like so:
```erb
<%= render_component "header" do %>
  <p>Hello World</p>
<% end %>
```

Would output the following in your view:

```erb
<div class="header">
  <p>Hello World</p>
</div>
```


### Assets
You can require all the components CSS and JS automatically by requiring `mountain_view` in your main JS and CSS files.

### Global Stylesheets
In case you want to add global stylesheets (e.g. reset, bootstrap, a grid system, etc) to your Mountain View components you can do it by calling them with an initializer

```ruby
#config/initializers/mountain_view.rb

MountainView.configure do |config|
  config.included_stylesheets = ["reset", "bootstrap"]
end

```

```
//= require mountain_view
```

You don't need to require those again in your application if you're requiring
`mountain_view` already, that will cause duplicate CSS.

For SASS mixins, variables, functions, etc (anything that doesn't generate
code), you'd need to explicitly do and `@import` in each component stylesheet.
As that doesn't generate extra CSS this won't cause any issues with the
generated CSS, you're only giving that stylesheet access to those definitions.


### Adding extra pages to the styleguide
In case you want to add additional pages to the styleguide (e.g grid, code_style) to your living style guide, you can do it by generating them in an initializer

```ruby
MountainView.configure do |config|
  config.extra_pages = [:grid, :code_style]
end
```

This will generate the routes and conventional links to the style guide.

To add the views to handle the request.

```
rails generate mountain_view:extra_pages
```

## Automatically generated Style Guide
A style guide will be automatically generated. This style guide never falls behind and it reflects your components in their latest version.

#### Setting up the style guide
1) Add the following line to your `routes.rb` file. `/mountain_view` can be any path you want. 
```ruby
mount MountainView::Engine => "/mountain_view", as: "mv_style_guide"
```

Note: Adding `as: :mv_style_guide` is needed to establish a consistent name for the style guide to provide a link to the main page.

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
3) Visit `http://localhost:3000/mountain_view/styleguide`

#### Example Style Guide

Visit the **<a href="https://mountain-view.herokuapp.com/mountain_view/styleguide" target="_blank">living style guide demo!</a>**
(<a href="https://github.com/devnacho/mountain_view_demo" target="_blank">source repo</a>)

<a href="https://mountain-view.herokuapp.com" target="_blank">Usage of components demo here!</a>

![mountain_view](https://cloud.githubusercontent.com/assets/623766/7099771/5b06d8da-dfd4-11e4-8558-1b7f026f28ad.gif)

### Custom Routes

To override the path used within the mountain_view engine, set the `styleguide_path` option.

```ruby
#config/initializers/mountain_view.rb

MountainView.configure do |config|
  config.styleguide_path = "my-style-guide"
end
```

## Customizing Look and Feel

### Customizing the style guide

To customize the styleguide, override the style guide layout by adding `mountain_view.html.erb` (or mountain_view.html.haml if using haml) to your application layouts folder in views. 

### Custom meta data for stub examples

You can customize the title, description for each example in the stub, as well as the classes that surround the stub example.  In order to override the default title, add a `title` key to the `mv_stub_meta` hash.  Additional special keys include `description` which will add a description under the title for a given example, `classes` which will add classes for a specific example, and `partial` which will allow ou to embed the component in a partial (see below for details). 

E.g: `app/components/card/card.yml`
```yml
    -
      :mv_stub_meta:
        :title: "Specific Example"
        :description: "Instructions for use case or other UX considerations"
        :classes: "black-background"
        :layout: "card/card_styleguide_layout.html.erb"
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
```
### Wrapping Components in the Style Guide

Sometimes you may want to wrap extra content around the component in the style guide.  For example, you may want to include a form tag around a custom form component without including the form tag in the component itself. You can do this by adding the key `partial` in the `mv_stub_meta`.

To include the component in the partial, you reference `<%= content_for :"#{mv_content_for_name}" %>`

## Improving performance
Rendering a large amount of partials in a request can lead to a performance bottleneck, usually this is caused by the parsing and rendering of template code such as ERB or HAML.

Via a Mountain View component you can render your HTML without touching a template parsing engine, which is super performant! To do this, you'll need to override `render(context, &block)` method, which is inherited from `MountainView::Presenter` class.

For example, if you had a component called `blank_state` with the Erb of: 

```html
<!-- app/components/blank_state/_blank_state.html.erb -->
<div class="blank-state <%= properties[:class] %>"></div>
```

You'd override the `render` method in `blank_state_component.rb` like so: 

```ruby
# app/components/blank_state/blank_state_component.rb
class BlankStateComponent < MountainView::Presenter
  properties :class

  # Override the inherited render method to not read partials from the file system.
  def render(context, &block)
    # context is the view we've being rendered from, so it has all Rails helpers
    context.content_tag(:div, '', class: [
      'blank-state',
      properties[:class]
    ].compact.join(' '))
  end
end
```

Anecdotally, a request which had to render 50 partials and took a whopping 2000ms was reduced to 200ms using this technique.

## Contributing

See the [contributing guide](./CONTRIBUTING.md).

## Team

### Current Maintainers

* [Esteban Pastorino](https://github.com/kitop)
* [Ignacio Gutierrez](https://github.com/devnacho)

## Credits
This library was inspired by [Rizzo](http://rizzo.lonelyplanet.com/styleguide/ui-components/cards), a wonderful living style guide created by the guys at LonelyPlanet. [More info here](http://engineering.lonelyplanet.com/2014/05/18/a-maintainable-styleguide.html)
