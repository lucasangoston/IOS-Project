//
//  cameraToText.swift
//  SwiftProject
//
//  Created by Lucas Angoston on 27/07/2022.
//

import UIKit
import MapKit
import Contacts
import MessageUI

public var text : String?
public var receiver: [String]?
public var subject: String?
var img: Data?
var file : String?

open class cameraToText : UIViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate{

    open override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    open override func viewWillAppear(_ animated: Bool)
    {
        super.viewWillAppear(animated)
    }
    
    open override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(true)
    }

    public func initCameraToText(){
  takePhoto()
}

    public func setData(txt: String, rec: [String]?, subj: String?)
    {
        text = txt
        receiver = rec ?? nil
        subject = subj ?? nil
    }
private func sendMSG()
{
let msg = MFMessageComposeViewController()
msg.messageComposeDelegate = self
msg.recipients = receiver ?? nil
msg.subject = subject ?? nil
msg.body = text
if !(img == nil){
msg.addAttachmentData(img!, typeIdentifier: "public.data", filename: file!)
}
    self.present(msg, animated: true)
}


private func takePhoto() {
    let cameraVC = UIImagePickerController()
    cameraVC.sourceType = .camera
    cameraVC.allowsEditing = false
    cameraVC.delegate = self
    self.present(cameraVC, animated: true)
}

    public func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
picker.dismiss(animated: true)

     guard let imgData = info[.originalImage] as? UIImage else{
         print("error")
         return
     }
            img = imgData.pngData()
           file = "image.png"
        sendMSG()
 

}
}


extension cameraToText: MFMessageComposeViewControllerDelegate {
    public func messageComposeViewController(_ controller: MFMessageComposeViewController, didFinishWith result: MessageComposeResult) {
        print(result)
        
        switch result {
        case .cancelled:
            dismiss(animated: true)
        case .sent:
            dismiss(animated: true)
            let successPopUp = UIAlertController(title: "Message Sent", message: "Your message has been sent.", preferredStyle: .alert)
            successPopUp.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
            self.present(successPopUp, animated: true)
        case .failed:
            dismiss(animated: true)
            let successPopUp = UIAlertController(title: "Message Failed To Sent", message: "Your message has failed to send.", preferredStyle: .alert)
            successPopUp.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
            self.present(successPopUp, animated: true)
        @unknown default:
            dismiss(animated: true)
        }
    }
}
