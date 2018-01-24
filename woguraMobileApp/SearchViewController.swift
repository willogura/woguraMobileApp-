//
//  SearchViewController.swift
//  woguraMobileApp
//
//  Created by William Ogura on 5/7/17.
//  Copyright © 2017 Microsoft. All rights reserved.
//

import UIKit

class SearchViewController: UIViewController {
    
    @IBOutlet weak var searchInput: UITextField!
    @IBOutlet weak var searchOutput: UITextView!
    
    @IBOutlet weak var clearResultsButton: UIButton!
    var table : MSSyncTable?
    var store : MSCoreDataStore?
    
    lazy var fetchedResultController: NSFetchedResultsController<NSFetchRequestResult> = {
        let fetchRequest:NSFetchRequest<NSFetchRequestResult> = NSFetchRequest(entityName: "TodoItem")
        let managedObjectContext = (UIApplication.shared.delegate as! AppDelegate).managedObjectContext!
        
        // show only non-completed items
        fetchRequest.predicate = NSPredicate(format: "complete != true")
        
        // sort by item text
        fetchRequest.sortDescriptors = [NSSortDescriptor(key: "createdAt", ascending: true)]
        
        // Note: if storing a lot of data, you should specify a cache for the last parameter
        // for more information, see Apple's documentation: http://go.microsoft.com/fwlink/?LinkId=524591&clcid=0x409
        let resultsController = NSFetchedResultsController(fetchRequest: fetchRequest, managedObjectContext: managedObjectContext, sectionNameKeyPath: nil, cacheName: nil)
        
       // resultsController.delegate = self
        return resultsController
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        let client = MSClient(applicationURLString: "https://woguramobileapp.azurewebsites.net")
        let managedObjectContext = (UIApplication.shared.delegate as! AppDelegate).managedObjectContext!
        self.store = MSCoreDataStore(managedObjectContext: managedObjectContext)
        client.syncContext = MSSyncContext(delegate: nil, dataSource: self.store, callback: nil)
       
        
   
        
        // Refresh data on load
    

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    
    @IBAction func searchPressed(_ sender: Any) {
        
        
        getResults()
        
        
    }
    
   
    
    @IBAction func clearResultsPressed(_ sender: Any) {
        
   resetResults()
        
    }
    
    
    
    
    override func viewDidDisappear(_ animated: Bool) {
        
        
resetResults()
        
    }
    
    func resetResults() {
        
        
        searchInput.text = nil
        searchOutput.text = nil
        
        
        clearResultsButton.isHidden = true
        
        
        
        
        
    }
    
    
    func fetchResults() {
        var error : NSError? = nil
        do {
            try self.fetchedResultController.performFetch()
        } catch let error1 as NSError {
            error = error1
            print("Unresolved error \(error), \(error?.userInfo)")
            abort()
        }
        
        
        
        
        
    }
    
    
    override func viewDidAppear(_ animated: Bool) {
        
      fetchResults()
        
        
    }
    
    func getResults() {
    /*
    let record = self.fetchedResultController.object(at: indexPath) as! NSManagedObject
    var item = self.store!.tableItem(from: record)
    item["complete"] = true
    
    UIApplication.shared.isNetworkActivityIndicatorVisible = true
    
    self.table!.update(item) { (error) -> Void in
    UIApplication.shared.isNetworkActivityIndicatorVisible = false
    if error != nil {
    print("Error: \((error! as NSError).description)")
    return
    }
    }
      */
      let item =  self.fetchedResultController.fetchedObjects 
       // let item = self.fetchedResultController.object(at: indexPath) as! NSManagedObject
        
        // Set the label on the cell and make sure the label color is black (in case this cell
        // has been reused and was previously greyed out
        
        
        /*
        if let text = item.value(forKey: "customerName") as? String {
            print("Text \(text)")
        } else {
            print("no good")
        }
        
        */
        
       
        
       
        
        
    var index =  IndexPath(row: 0, section: 0)
        
        
        
       
        
        for it in item! {
            
             var Result = [String]()
            
             let item2 =  self.fetchedResultController.object(at: index) as! NSManagedObject
            
            
          if let text = item2.value(forKey: "customerName") as? String {
            
            
            
            if (text.contains(searchInput.text!)) {
                
                
                
              Result.append("Name: \(text)")
                
                if let address1 = item2.value(forKey: "address1") as? String {
                    
                    Result.append("Address 1: \(address1)")
                    
                }
                
                
                if let address2 = item2.value(forKey: "address2") as? String {
                    
                    Result.append("Address 2: \(address2)")
                    
                }
                
                
                if let city = item2.value(forKey: "city") as? String {
                    
                    Result.append("City: \(city)")
                    
                }
                
                if let state = item2.value(forKey: "customerState") as? String {
                    
                    Result.append("State: \(state)")
                    
                }
                
                if let zip = item2.value(forKey: "zip") as? String {
                    
                    Result.append("Zip Code: \(zip)")
                    
                }
                
                
               
                
                
                
                for section in Result {
                    
                    searchOutput.text = searchOutput.text + ("\n\(section)")
                    
                    clearResultsButton.isHidden = false
                    
                    
                    
                    
                    
                }
                
                
                
                
                
                
            }
            
            }
            
            index.row = index.row + 1
                              
            
        }
        
        
        
        
    }
    
    
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
