UITabBar.appearance().barTintColor = API.PrimaryColor()
self.tabBar.tintColor = UIColor.black
if #available(iOS 10.0, *) {
    self.tabBar.unselectedItemTintColor = API.DarkPrimaryColor()
}
UITabBar.appearance().backgroundColor = API.PrimaryColor()
self.tabBarController?.tabBar.backgroundColor = API.PrimaryColor()
