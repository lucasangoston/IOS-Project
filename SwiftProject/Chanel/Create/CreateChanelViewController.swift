//
//  CreateChanelViewController.swift
//  SwiftProject
//
//  Created by Lucas Angoston on 25/07/2022.
//

import UIKit

class CreateChanelViewController: UIViewController {
    var chanelService: ChanelService = ChanelWebService()
    let defaults = UserDefaults.standard
    
    @IBOutlet var chanelNameTextField: UITextField!
    @IBOutlet var chanelThemeTextField: UITextField!
    @IBOutlet var chanelDescriptionTextField: UITextField!
    @IBOutlet var submitChanelButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        submitChanelButton.isEnabled = false;
        let textfields : [UITextField] = [chanelNameTextField, chanelThemeTextField, chanelDescriptionTextField]
        
        for textfield in textfields {
          textfield.addTarget(self, action: #selector(textFieldDidChange(_:)), for: .editingChanged)
        }
    }
    
    @IBAction func handleSubmitChanelButton(){
        chanelService.createChanel(chanelName: chanelNameTextField.text!, chanelDescription: chanelDescriptionTextField.text!, chanelTheme: chanelThemeTextField.text!)
        
        let alert = UIAlertController(title: NSLocalizedString("createChanel.title", comment: "Default action"), message: NSLocalizedString("createChanel.message", comment: "Default action"), preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: NSLocalizedString("OK", comment: "Default action"), style: .default, handler: { _ in
        NSLog("The \"OK\" alert occured.")
        }))
        self.present(alert, animated: true, completion: nil)
        
        self.presentationController?.dismissalTransitionWillBegin()
    }
    
    @objc func textFieldDidChange(_ textField: UITextField) {
        if chanelNameTextField != nil && chanelNameTextField.text != "" &&
            chanelThemeTextField != nil && chanelThemeTextField.text != ""  &&
            chanelDescriptionTextField != nil && chanelDescriptionTextField.text != ""{
            submitChanelButton.isEnabled = true
        } else {
            submitChanelButton.isEnabled = false
        }
    }


    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
