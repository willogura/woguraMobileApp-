// ----------------------------------------------------------------------------
// Copyright (c) Microsoft Corporation. All rights reserved.
// ----------------------------------------------------------------------------
//
// Licensed under the Apache License, Version 2.0 (the "License");
// you may not use this file except in compliance with the License.
// You may obtain a copy of the License at
// http://www.apache.org/licenses/LICENSE-2.0
//
// Unless required by applicable law or agreed to in writing, software
// distributed under the License is distributed on an "AS IS" BASIS,
// WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
// See the License for the specific language governing permissions and
// limitations under the License.
//

import Foundation
import UIKit

protocol ToDoItemDelegate {
    func didSaveItem(_ customer : Customer)
}

class Customer {
    
    var customerName: String
    
    var address1: String
    var address2: String
    var zip: String
    var city: String
    var state: String
    
    init(name: String, address1: String, address2: String, zip: String, city: String, state: String) {
        
        self.customerName = name
        self.address1 = address1
        self.address2 = address2
        self.city = city
        self.zip = zip
        self.state = state
        
        
        
    }
    
    
}

class ToDoItemViewController: UIViewController,  UIBarPositioningDelegate, UITextFieldDelegate {
    
  
    
    @IBOutlet weak var customerName: UITextField!
    
    
    @IBOutlet weak var address1: UITextField!
    
    @IBOutlet weak var address2: UITextField!
    
    
    @IBOutlet weak var city: UITextField!
    
    @IBOutlet weak var customerState: UITextField!
    
    
    @IBOutlet weak var zip: UITextField!
    
    
    
    var delegate : ToDoItemDelegate?
    
    override func viewDidLoad()
    {
        super.viewDidLoad()
        
  
    }
    
    @IBAction func cancelPressed(_ sender : UIBarButtonItem) {
        _ = self.navigationController?.popViewController(animated: true)
    }
    
    @IBAction func savePressed(_ sender : UIBarButtonItem) {
        saveItem()
        _ = self.navigationController?.popViewController(animated: true)
    }
    
  
    // Delegate
    
    func saveItem()
    {
         var customer = Customer(name: customerName.text!, address1: address1.text!, address2: address2.text!, zip: zip.text!, city: city.text!, state: customerState.text!)
            
            
            
            self.delegate?.didSaveItem(customer)
            
            
            
        
    }
}
