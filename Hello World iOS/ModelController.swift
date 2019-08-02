import UIKit

/*
 A controller object that manages a simple model -- a collection of month names.
 
 The controller serves as the data source for the page view controller; it therefore implements pageViewController:viewControllerBeforeViewController: and pageViewController:viewControllerAfterViewController:.
 It also implements a custom method, viewControllerAtIndex: which is useful in the implementation of the data source methods, and in the initial configuration of the application.
 
 There is no need to actually create view controllers for each page in advance -- indeed doing so incurs unnecessary overhead. Given the data model, these methods create, configure, and return a new view controller on demand.
 */


class ModelController: NSObject, UIPageViewControllerDataSource {

    var pageData: [String] = []

    // This is the constructor for this object within Swift
    override init() {
        super.init()
        // Create the data model.
        let dateFormatter = DateFormatter()
        self.pageData = dateFormatter.monthSymbols
    }

    // This function will pass in a numeric index in order to return the proper DataViewController at that index
    func viewControllerAtIndex(_ index: Int, storyboard: UIStoryboard) -> DataViewController? {
        // If the index passed in is over the total amount of pages, then we simply return nil and leave the function
        if (self.pageData.count == 0) || (index >= self.pageData.count) {
            return nil
        }

        // Create a new view controller and pass suitable data.
        let dataViewController = storyboard.instantiateViewController(withIdentifier: "DataViewController") as! DataViewController
        // This is where the data is set
        dataViewController.dataObject = self.pageData[index]
        return dataViewController
    }

    func indexOfViewController(_ viewController: DataViewController) -> Int {
        // Return the index of the given data view controller.
        // For simplicity, this implementation uses a static array of model objects and the view controller stores the model object; you can therefore use the model object to identify the index.
        return pageData.firstIndex(of: viewController.dataObject) ?? NSNotFound
    }

    // This function will return the previous page of the data set
    func pageViewController(_ pageViewController: UIPageViewController, viewControllerBefore viewController: UIViewController) -> UIViewController? {
        // Check the index of the page that is currently visible
        var index = self.indexOfViewController(viewController as! DataViewController)
        // Return nil if the page is already at the first piece of data
        if (index == 0) || (index == NSNotFound) {
            return nil
        }
        
        // subtract 1 to the index
        index -= 1
        // return the view controller at the new index
        return self.viewControllerAtIndex(index, storyboard: viewController.storyboard!)
    }

    // This function will get the view controller after the current page
    func pageViewController(_ pageViewController: UIPageViewController, viewControllerAfter viewController: UIViewController) -> UIViewController? {
        // Gets the index of the current page
        var index = self.indexOfViewController(viewController as! DataViewController)
        // if the return value of the last function was invalid then we just skip this
        if index == NSNotFound {
            return nil
        }
        
        // add one to our index
        index += 1
        // If the index is equal to all pages then we want to simply return nil and exit the function
        if index == self.pageData.count {
            return nil
        }
        
        // return the view controller of the new index
        return self.viewControllerAtIndex(index, storyboard: viewController.storyboard!)
    }
}
