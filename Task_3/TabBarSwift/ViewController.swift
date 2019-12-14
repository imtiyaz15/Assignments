

import UIKit

class ViewController: UIViewController {

    let theTabBar = UITabBarController()

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        theTabBar.tabBar.tintColor = UIColor.black
        createTabBarController()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


      func createTabBarController() {
    
        let firstVc = UIViewController()
        firstVc.title = "Home"
        firstVc.view.backgroundColor =  UIColor.red
        firstVc.tabBarItem = UITabBarItem.init(title: "Home", image: UIImage(named: "HomeTab"), tag: 0)
        
        let secondVc = UIViewController()
        secondVc.title = "Location"
        secondVc.view.backgroundColor =  UIColor.green
        secondVc.tabBarItem = UITabBarItem.init(title: "Location", image: UIImage(named: "Location"), tag: 1)

        let controllerArray = [firstVc, secondVc]
        theTabBar.viewControllers = controllerArray.map{ UINavigationController.init(rootViewController: $0)}
        
        self.view.addSubview(theTabBar.view)
    }
    
}

