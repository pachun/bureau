class AppDelegate
  def application(application, didFinishLaunchingWithOptions:launchOptions)
    return true if RUBYMOTION_ENV == 'test'

    @x = BlueVC.new
    @y = GreenVC.new
    structure = [
      {
        # title: "Section 1",
        drawers: [
          {
            title: "Drawer 1-1",
            subtitle: "Hey 1",
            accessory: UITableViewCellAccessoryCheckmark,
            controller: @x,
          },
          {
            title: "Drawer 1-2",
            subtitle: "Hey 2",
            icon: UIImage.imageNamed("martini.png"),
            controller: @y,
          }
        ]
      },
      {
        title: "Section 2",
        drawers: [
          {
            title: "Drawer 2-1",
            subtitle: "Hey 3",
            target: self,
            action: :say_hello,
          },
          {
            title: "Drawer 2-2",
            subtitle: "Hey 4",
          }
        ]
      },
    ]

    bureau = Bureau::Bureau.new(structure:structure,
                                state: :open,
                                slide_width: 500,
                                active_cell_color: UIColor.clearColor,
                                drawer_separators: :none,
                               )
    @window = UIWindow.alloc.initWithFrame UIScreen.mainScreen.bounds
    @window.rootViewController = bureau
    @window.makeKeyAndVisible

    true
  end

  def say_hello
    UIAlertView.alloc.initWithTitle("Hi", message:'', delegate:self,cancelButtonTitle:"OK",otherButtonTitles:nil).show
  end
end

class GreenVC < UIViewController
  include Bureau::Controller

  def init
    view.backgroundColor = UIColor.greenColor
    @button = UIButton.buttonWithType UIButtonTypeRoundedRect
    @button.setTitle("Tap Me", forState:UIControlStateNormal)
    @button.backgroundColor = UIColor.redColor
    @button.frame = CGRectMake(50, 50, 150, 50)
    @button.addTarget(self, action: :toggle_menu, forControlEvents:UIControlEventTouchUpInside)
    view.addSubview(@button)
    super
  end

  def toggle_menu
    toggle_bureau
  end
end

class BlueVC < UIViewController
  include Bureau::Controller

  def init
    view.backgroundColor = UIColor.blueColor
    super
  end
end
