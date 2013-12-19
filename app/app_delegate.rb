class AppDelegate
  def application(application, didFinishLaunchingWithOptions:launchOptions)
    return true if RUBYMOTION_ENV == 'test'

    structure = [
      {
        title: "Section 1",
        drawers: [
          {
            title: "Drawer 1-1",
            subtitle: "Hey 1",
            accessory: UITableViewCellAccessoryCheckmark,
            controller: BlueVC.new,
          },
          {
            title: "Drawer 1-2",
            subtitle: "Hey 2",
            icon: UIImage.imageNamed("martini.png"),
            controller: GreenVC.new,
          }
        ]
      },
      {
        title: "Section 2",
        drawers: [
          {
            title: "Drawer 2-1",
            subtitle: "Hey 3",
          },
          {
            title: "Drawer 2-2",
            subtitle: "Hey 4",
          }
        ]
      },
    ]

    @window = UIWindow.alloc.initWithFrame UIScreen.mainScreen.bounds
    @window.rootViewController = Bureau::Bureau.new(structure:structure, state: :open)
    @window.makeKeyAndVisible
    true
  end
end

class GreenVC < UIViewController
  def init
    view.backgroundColor = UIColor.greenColor
    super
  end
end

class BlueVC < UIViewController
  def init
    view.backgroundColor = UIColor.blueColor
    super
  end
end
