Bureau
-
Custom animated sidemenu controller.

![alt text](http://i.imgur.com/uUWU1F7.png "Bureau!")

###Install

```ruby
gem 'bureau', '>=0.0.2', git: 'git://github.com/pachun/bureau.git'
```

###Usage

The constructor takes a hash that requires a :structure key:
```ruby
brueau = Bureau::Bureau.new(structure: [])
```
The :structure key's value must be formatted correctly, or bureau will raise an error.

###Structure

Simply put, it is an array of hashes, each of which represents a section in the sidemenu. So, the following would be valid to create a table consisting solely of section headers:
```ruby
structure = [
  {title: "Section 1"},
  {title: "Section 2"},
  {title: "Section 3"},
]
Bureau::Bureau.new(structure: structure)
```

###Sections

The section hashes in the structure key can have the :title and :drawers keys. Both are optional. :title's purpose is obvious and the value of the :drawers key should be an array of hashes, each of which represent a *drawer* in that section.

###Drawers

A drawer is a row and they have the following configurable keys:

__:title__
__:subtitle__
If set, these should obviously be strings.

__:icon__
__:accessory__
If set, these are both UIImage's, but :accessory can also be set to any one of the [UITableViewCellAccessoryType constants](https://developer.apple.com/library/ios/documentation/uikit/reference/UITableViewCell_Class/Reference/Reference.html#//apple_ref/doc/c_ref/UITableViewCellAccessoryType).

__:controller__
This should be set to some kind of UIViewController. When a drawer with a controller key is tapped, the active view switches to the controller's view and the menu animates shut.
It's important to know that any controller you use for this must have the Bureau::Controller module mixed in so that anywhere within that controller you can call the :toggle_bureau method to animate open and shut the sidemenu. If you feel like polluting all your controllers with that method:
```ruby
class UIViewController < UIResponder
  include Bureau::Controller
end
```
I didn't want to do that to you out of the box. That will apply the UINavigationControllers as well.
Also, you can either set this key to a UIViewController class, or instance. If you set it to an instance, the same controller instance will be used every time the drawer is tapped. Likewise, if you tap a drawer with a Class controller, a new instance of that class is used each time it's tapped.
```ruby
class UIViewController < UIResponder
  include Bureau::Controller
end

structure = [
  {
    title:"Section 1",
    drawers: [
      {title: "Same View Controller", controller:UIViewController.new},
      {title: "New View Controller", controller:UIViewController},
    ],
  }
]
bureau = Bureau::Bureau(structure: structure)
```

__:target__
__:action__
Having these keys is the alternative to using the :controller key. Instead of switching to a new view, when a row with a :controller key is tapped, a row with a target/action key pair just runs the specified method. I thought it may be useful for short *About* popups and such. Tapping one of these rows will not animate shut the sidemenu by default.

###Other Customizations
In addition to the structure key, the initialization hash takes some optional parameters:
```ruby
bureau = Bureau::Bureau.new(
  structure: structure,

  # these are all optional:
  state: :open, # defaults to :closed
  drawer_height: 30, # defaults to 50
  header_height: 50, # defaults to 60
  slide_width: 310, # defaults to 300
  slide_duration: 1.0, # defaults to 0.3
  status_bar_color: UIColor.redColor, # defaults to white
)
```

###Further Customization
You can also subclass Bureau::Bureau and use the following hooks to customize
cells and header views:
```ruby
class MyBureau < Bureau::Bureau
  def customize(cell, in_section:section, row:row)
    cell.backgroundColor = UIColor.greenColor
    cell
  end

  def customize_header_in_section(section)
    header = UIView.alloc.initWithFrame(CGRectMake(0,0,320,50))
    header.backgroundColor = UIColor.yellowColor
    header
  end
end
```
The customize_header_in_section: method is called if you leave out the :title
key in a section hash.

###Quick Note

If one of your drawer controllers is a UINavigationController, you have to mix Bureau::Controller into the UINavigationController class, and to toggle the side menu, you would then call:
```ruby
def toggle
  navigationController.toggle_bureau
end
```

That's all. Feedback and pull requests appreciated.