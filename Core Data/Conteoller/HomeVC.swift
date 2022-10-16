//
//  ViewController.swift
//  Core Data
//
//  Created by Hassan on 18/05/2022.
//

import UIKit

enum Opreation{
    case Update
    case Add
}

// MARK: ViewDidLoad, Segue, Delegate
class HomeVC: UIViewController , Delegate {
   
    
    
    
    let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    
  
    
    
    let alert = AlretVC()
    @IBOutlet weak var tableView : UITableView!
    var items:[ItemCoreData] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        tableView.register(ItemCell.nib(), forCellReuseIdentifier: ItemCell.identifier)
        tableView.register(UINib(nibName: "testedCell", bundle: nil), forCellReuseIdentifier: "testCell")
        fetchItems()
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let vc = segue.destination as! AddVC
        vc.delegate = self
        vc.opreation = .Add
    }
    
    func addNewItem() {
        
        do{
            try context.save()
            fetchItems()
        }
        catch
        {
            alert.erorrAlert(message: "Faild to add new item")
        }
    }
    
    func update() {
        do{
            try context.save()
            fetchItems()
        }
        catch
        {
            alert.erorrAlert(message: "Faild to update item")
        }
    }   
    
    
}

// MARK: TableView Data Source
extension HomeVC :  UITableViewDataSource
{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        items.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        
        let cell = tableView.dequeueReusableCell(withIdentifier: ItemCell.identifier) as! ItemCell
        
        
        
        let item = items[ items.count - indexPath.row - 1]
        cell.titleLabel.text = item.title
        cell.detailsLabel.text = item.details
        cell.dateLabel.text    = item.createdDate
        
        if let img = item.image{
            cell.imgView.image = UIImage(data: img)
            cell.imgView.layer.cornerRadius = cell.imgView.frame.width / 2
        }
        
        
        return cell
    }
    
    
    
}
// MARK: TableView Delegate
extension HomeVC : UITableViewDelegate
{
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return view.frame.height * 0.12
    }
    
    func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        return true
    }

    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if (editingStyle == .delete) {
            let item = items[items.count - indexPath.row - 1]
            items.remove(at:items.count - indexPath.row - 1 )
            context.delete(item)
            do{
            try context.save()
            }
            catch
            {
                alert.erorrAlert(message: "Faild to delete")
            }
                fetchItems()
        }
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let addVC = storyboard?.instantiateViewController(withIdentifier: "AddVC") as! AddVC
        addVC.opreation = .Update
        addVC.delegate  = self
        addVC.item = items[items.count - indexPath.row - 1]
        navigationController?.pushViewController(addVC, animated: true)
        
    }
}


// MARK: Fetching Data
extension HomeVC{
    
    func fetchItems()
    {
        let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
        do{
            
            items = try context.fetch(ItemCoreData.fetchRequest())
            DispatchQueue.main.async {
                self.tableView.reloadData()
            }
        }
        catch{
            alert.erorrAlert(message: "Error Fitching Data")
        }
    }
}



