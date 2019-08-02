//
//  RootViewController.swift
//  Hello World iOS
//
//  Created by bryce meyer on 8/2/19.
//  Copyright © 2019 bryce meyer. All rights reserved.
//

import UIKit

class RootViewController: UIViewController, UIPageViewControllerDelegate {

    // This variable is a reference to the main iOS class that controls pages
    var pageViewController: UIPageViewController?

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        // Configure the page view controller and add it as a child view controller.
        self.pageViewController = UIPageViewController(transitionStyle: .pageCurl, navigationOrientation: .horizontal, options: nil)
        self.pageViewController!.delegate = self
    }

    // This function will take us to the data view controller page that you can see within the storyboard
    // Adding the decleration @IBAction to a function allows you to interact with it from within the Interface Builder
    @IBAction func goToDataViewController() {
        // This will allow us to reference the starting view controlelr that we re moving from
        let startingViewController: DataViewController =
            self.modelController.viewControllerAtIndex(0, storyboard: self.storyboard!)!
        // We are now going to store our view controllers in an array
        let viewControllers = [startingViewController]
        // This will then tell our app to animate to the next view controller
        self.pageViewController!.setViewControllers(viewControllers, direction: .forward, animated: true, completion: {done in })

        // This sets the data source of the new page as the local instance of our ModelController
        self.pageViewController!.dataSource = self.modelController

        // This will add the page view controller that we just finished setting up to the main controller
        self.addChild(self.pageViewController!)
        // This will add the data view controller view to the currently visible view
        self.view.addSubview(self.pageViewController!.view)

        // Set the page view controller's bounds using an inset rect so that self's view is visible around the edges of the pages.
        var pageViewRect = self.view.bounds
        if UIDevice.current.userInterfaceIdiom == .pad {
            pageViewRect = pageViewRect.insetBy(dx: 40.0, dy: 40.0)
        }
        self.pageViewController!.view.frame = pageViewRect

        self.pageViewController!.didMove(toParent: self)
    }

    // This is a variable decleration, and in swift you can attach a function to a variable decleration that will run when the variable is accessed.
    var modelController: ModelController {
        // Return the model controller object, creating it if necessary.
        // In more complex implementations, the model controller may be passed to the view controller.
        if _modelController == nil {
            // This creates a new instance of our ModelController, and ensures that it is set
            _modelController = ModelController()
        }
        // The exclamation point at the end of this statement tells swift to unwrap the value. The variable is delecated as either bing a ModelController, or nil. By using this exclamation point you can tell swift to return the value as if it is impossible for it to be nil
        return _modelController!
    }

    // Here we instantiage a nullable instance of our ModelControlller, and immediately set it to nil, Swift's version of null
    var _modelController: ModelController? = nil
}
