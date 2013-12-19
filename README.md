Bureau
-
![alt text](http://i.imgur.com/uUWU1F7.png "Bureau!")
####Install
```ruby
gem 'bureau', '>=0.0.2', git: 'git://github.com/pachun/bureau.git'
```

####Usage
```ruby
class AppDelegate
  def application(application, didFinishLaunchingWithOptions:launchOptions)
    true

    nav = UINavigationController.alloc.initWithRootViewController(BlueVC.new)
    structure = [
      {
        title: "Section 1",
        drawers: [
          # the following uses the same GreenVC instance every time
          {title: 'Drinks', controller: GreenVC.new, icon: UIImage.imageNamed('martini.png')},

          # the following uses a new GreenVC instance every time
          {title: 'More Drinks', controller: GreenVC, icon: UIImage.imageNamed('martini.png')},
        ],
      },
      {
        title: "Section 2",
        drawers: [
          # this does what you'd expect...
          {title: 'Say Hello', target: self, action: :say_hello}
        ]
      },
      {
        title: "Section 2",
        drawers: [
          # the :accessory key can be set to a UIView also
          {title: 'Open Nav', controller: nav, accessory: UITableViewCellAccessoryCheckmark}
        ]
      }
    ]
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

    @window = UIWindow.alloc.initWithFrame UIScreen.mainScreen.bounds
    @window.rootViewController = bureau
    @window.makeKeyAndVisible
  end

  def say_hello
    UIAlertView.alloc.initWithTitle("Hello!", message:'', delegate:self,cancelButtonTitle:"OK",otherButtonTitles:nil).show
  end
end

class GreenVC < UIViewController
  include Bureau::Controller

  def init
    view.backgroundColor = UIColor.greenColor
    view.addSubview(button)
    super
  end

  def button
    b = UIButton.buttonWithType UIButtonTypeRoundedRect
    b.setTitle("Tap Me", forState:UIControlStateNormal)
    b.backgroundColor = UIColor.whiteColor
    b.frame = CGRectMake(50, 50, 150, 50)
    b.addTarget(self, action: :toggle, forControlEvents:UIControlEventTouchUpInside)
    b
  end

  def toggle
    toggle_bureau
  end
end

class UINavigationController
  include Bureau::Controller
end

class BlueVC < UIViewController
  def init
    view.backgroundColor = UIColor.blueColor
    view.addSubview(button)
    super
  end

  def button
    b = UIButton.buttonWithType UIButtonTypeRoundedRect
    b.setTitle("Tap Me", forState:UIControlStateNormal)
    b.backgroundColor = UIColor.whiteColor
    b.frame = CGRectMake(50, 50, 150, 50)
    b.addTarget(self, action: :toggle, forControlEvents:UIControlEventTouchUpInside)
    b
  end

  def toggle
    navigationController.toggle_bureau
  end
end
```

You can also subclass Bureau::Bureau and use the following hooks to customize
cells and header views:
```ruby
class MyBureau < Bureau::Bureau
  def customize(cell, in_section:section, row:row)
    cell.backgroundColor = UIColor.greenColor
    cell
  end

  def customize_header_in_section(section)
    UIView.alloc.initWithFrame(CGRectMake(0,0,20,20))
  end
end
```
The customize_header_in_section: method is called if you leave out the :title
key in a section hash.
