//
//  ViewController.swift
//  MobileLabP2PKit
//
//  Created by Nien Lam on 3/7/19.
//  Copyright © 2019 Line Break, LLC. All rights reserved.
//

import UIKit

////////////////////////////////////////////////////////////////////
// NOTE: Update to unique name.
// Service type must be a unique string, at most 15 characters long
// and can contain only ASCII lowercase letters, numbers and hyphens.
let ServiceType = "mobile-lab"


class ViewController: UIViewController, UITextFieldDelegate, MultipeerServiceDelegate {

    @IBOutlet weak var inputTextField: UITextField!
    @IBOutlet weak var textView: UITextView!
    @IBOutlet weak var connectionsTextView: UITextView!

    // Popup for entering username.
    var alert : UIAlertController!

    // Service for handling P2P communication.
    var multipeerService: MultipeerService?

    // Display name.
    var username = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Set delegate for input field.
        inputTextField.delegate = self

        // Setting for text view to allow auto scroll to bottom.
        textView.layoutManager.allowsNonContiguousLayout = false

        // Prompt user to input username and start P2P communication.
        restart()
    }
    
    // Show popup for entering username, P2P servic will start when name entered.
    func restart() {
        // Clear text view.
        textView.text = ""

        // Create alert popup.
        alert = UIAlertController(title: "Enter your username", message: nil, preferredStyle: .alert)
        alert.addTextField(configurationHandler: { textField in
            textField.placeholder = "Username..."
            textField.addTarget(self, action: #selector(self.alertTextFieldDidChange(_:)), for: .editingChanged)
        })
        
        // Create action on OK press.
        let action = UIAlertAction(title: "OK", style: .default, handler: { action in
            if let name = self.alert.textFields?.first?.text {
                // Save username and set to title.
                self.username = name
                self.navigationItem.title = name

                ///////////////////////////////////////////////////////
                // NOTE: Start P2P.
                self.startMultipeerService(displayName: name)
                ///////////////////////////////////////////////////////

            }
        })
        action.isEnabled = false
        alert.addAction(action)

        // Show alert popup.
        self.present(alert, animated: true)
    }

    // Disable okay button when text field is empty.
    @objc func alertTextFieldDidChange(_ sender: UITextField) {
        alert.actions[0].isEnabled = sender.text!.count > 0
    }

    // Start multipeer service with display name.
    func startMultipeerService(displayName: String) {
        self.multipeerService = nil
        self.multipeerService = MultipeerService(dispayName: displayName)
        self.multipeerService?.delegate = self
        
    }

    // Send message to other peers and append to text view on button press.
    @IBAction func didTapSendButton(_ sender: UIButton) {
        guard let text = inputTextField.text, text.count > 0 else { return }

        // Prepend usename to msg.
        let msg = self.username + ": " + text

        /////////////////////////////////////////////
        // NOTE: Send msg to other peers.
        multipeerService?.send(msg: msg)
        /////////////////////////////////////////////

        // Append msg to text view.
        appendText(msg)

        // Clear input field.
        inputTextField.text = ""
    }

    // Dismisses keyboard when done is pressed.
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        view.endEditing(true)
        return false
    }

    // Append text and scroll to bottom of text view.
    func appendText(_ string: String) {
        textView.text += "\n" + string
        textView.scrollRangeToVisible(NSMakeRange(textView.text.count, 0))
    }

    @IBAction func didTapRedButton(_ sender: UIButton) {
        // Change background color.
        self.view.backgroundColor = .red

        // Send msg to other peers.
        let msg = "Color:Red"
        multipeerService?.send(msg: msg)
    }
    
    @IBAction func didTapYellowButton(_ sender: UIButton) {
        // Change background color.
        self.view.backgroundColor = .yellow

        // Send msg to other peers.
        let msg = "Color:Yellow"
        multipeerService?.send(msg: msg)
    }

    @IBAction func didTapRestartButton(_ sender: UIBarButtonItem) {
        restart()
    }
    
    @IBAction func didTapClearButton(_ sender: UIBarButtonItem) {
        textView.text = ""
    }
    

    //////////////////////////////////////////////////////////////////////////////////////////////
    // MARK: - MultipeerServiceDelegate
    
    // NOTE: Process when onnected devices have changed.
    func connectedDevicesChanged(manager: MultipeerService, connectedDevices: [String]) {
        DispatchQueue.main.async {
            self.connectionsTextView.text = "\(connectedDevices)"
        }
    }

    // NOTE: Process recieved msg.
    func receivedMsg(manager: MultipeerService, msg: String) {
        DispatchQueue.main.async {
        
            if msg == "Color:Red" {
                self.view.backgroundColor = .red
            } else if msg == "Color:Yellow" {
                self.view.backgroundColor = .yellow
            } else {
                self.appendText(msg)
            }
    
        }
    }
    //////////////////////////////////////////////////////////////////////////////////////////////
}
