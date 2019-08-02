import UIKit

class DataViewController: UIViewController {

    // This is the reference to the ui label created in the interface builder
    @IBOutlet weak var dataLabel: UILabel!
    
    // Our data object is simply a string, which will be assigned from somwewhere else
    var dataObject: String = ""

    // This overrides a parent function from the UIViewController class, and it takes care of finalizing the setup of our page
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        // We set the text of the UI label created in the interface builder with the current value of the data object
        self.dataLabel!.text = dataObject
    }
}
