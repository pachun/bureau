class AppDelegate
  def application(application, didFinishLaunchingWithOptions:launchOptions)
    sidemenu = Bureau::Bureau.new(
      state: :open,
      has_shadow: :yes,
      header_height: 44,
      structure: Structure
    )
    @window = UIWindow.alloc.initWithFrame(UIScreen.mainScreen.bounds)
    @window.rootViewController = sidemenu
    @window.makeKeyAndVisible
    true
  end
end

class WhiteVC < UIViewController
  def viewWillAppear(animated)
    super(animated)
    view.backgroundColor = UIColor.whiteColor
  end
end

class UIViewController < UIResponder
  include Bureau::Controller
  def shouldAutorotate
    true
  end
end

Structure = [
  {
    title: "Hello World",
    drawers: [
      {
        title: "Devils",
        controller: UINavigationController.alloc.initWithRootViewController(WhiteVC.new),
      },
      {
        title: "Redwings",
        controller: UINavigationController.alloc.initWithRootViewController(WhiteVC.new),
      }
    ]
  }
]
