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
          },
          {
            title: "Drawer 1-2",
            subtitle: "Hey 2",
            icon: UIImage.imageNamed("martini.png"),
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
    @window.rootViewController = Bureau::Bureau.new(structure:structure)
    @window.makeKeyAndVisible
    true
  end
end
