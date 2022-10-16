//
//  AddVC.swift
//  Core Data
//
//  Created by Hassan on 19/05/2022.
//

import UIKit
import CoreData

class AddVC: UIViewController{

    @IBOutlet weak var imgView: UIImageView!
    
    @IBOutlet weak var titleLabel: UITextField!
    
    @IBOutlet weak var breifDetailsTextView: UITextView!
    
    @IBOutlet weak var opreationBtn: UIButton!
    var delegate:Delegate?
    let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    
    var opreation : Opreation?
    var item:ItemCoreData?

    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        switch opreation
        {
        case .Add:
            opreationBtn.titleLabel?.text = "Save"

        case .Update:
            opreationBtn.titleLabel?.text = "Edit"
            if let img = item?.image
            {
                imgView.image =  UIImage(data: img)

            }
            titleLabel.text = item?.title
            breifDetailsTextView.text = item?.details
            
        case .none :
            print("Error Getting Opreation")
            
        }

    }
    
    @IBAction func addNewItemBtn(_ sender: Any) {
        
        switch opreation{
        case .Add:
            item = ItemCoreData(context: context)
            item?.details = breifDetailsTextView.text
            item?.image     = imgView.image?.pngData()
            item?.title   = titleLabel.text!
            item?.createdDate = ""
            delegate!.addNewItem()
            navigationController?.popViewController(animated: true)

        
        case .Update:
          
            
            let titleString  = "Warning"
                var myMutableString = NSMutableAttributedString()
            myMutableString = NSMutableAttributedString(string: titleString as String, attributes: [NSAttributedString.Key.font:UIFont.systemFont(ofSize: 15)])
                myMutableString.addAttribute(NSAttributedString.Key.foregroundColor, value: UIColor.red, range: NSRange(location:0,length:titleString.count))
            
            
            let alert = UIAlertController(title: "", message: "Are you sure you want to update this item", preferredStyle: .alert)
            alert.setValue(myMutableString, forKey: "attributedTitle")

            let yesAction = UIAlertAction(title: "Yes", style: .default) { [self] a in
                item?.details = breifDetailsTextView.text
                item?.image     = imgView.image?.pngData()
                item?.title   = titleLabel.text!
                item?.createdDate = ""
                delegate?.update()
                navigationController?.popViewController(animated: true)

            }
            
            let noAction = UIAlertAction(title: "No", style: .default, handler: nil)
            alert.addAction(noAction)
            alert.addAction(yesAction)

           
            present(alert, animated: true, completion: nil)
            
        case .none:
            print("Error Getting Opreation")

        }
      
    }
    
    @IBAction func selectImgBtn(_ sender: Any) {
        imageAlert()
        
    }
    
}


extension AddVC {
    
    func imageAlert()
    {
        let alret = UIAlertController(title: "Choose Image", message: "", preferredStyle: .actionSheet)
        
        let galaryAction = UIAlertAction(title: "Open Photos", style: .default) { _ in
            let imagePacker = UIImagePickerController()
            imagePacker.delegate = self
            imagePacker.sourceType = .photoLibrary
            imagePacker.allowsEditing = true
            self.present(imagePacker, animated: true, completion: nil)
            
        }
        
        let cameraAction = UIAlertAction(title: "Camera", style: .default) { _ in
            guard UIImagePickerController.isSourceTypeAvailable(.camera) else {return}
            
          /* let vc = UIImagePickerController()
            vc.sourceType = .camera
            vc.allowsEditing = true
            vc.delegate = self
            self.present(vc, animated: true) */
        }
        
        let canselAction = UIAlertAction(title: "Cansel", style: .cancel, handler: nil)
        
        alret.addAction(galaryAction)
        alret.addAction(cameraAction)
        alret.addAction(canselAction)
        present(alret, animated: true, completion: nil)
    }
    
}



extension AddVC :  UIImagePickerControllerDelegate & UINavigationControllerDelegate {
    
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        guard let image = info[.editedImage]   else {return}
        imgView.image = (image as! UIImage)
        dismiss(animated: true, completion: nil)
    }
    
}
