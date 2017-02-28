//
//  ViewController.swift
//  SampleLogin
//
//  Created by Appinventiv on 27/02/17.
//  Copyright © 2017 Appinventiv. All rights reserved.
//

import UIKit
import FBSDKCoreKit
import FBSDKLoginKit
import GoogleSignIn
import Google
import FBSDKShareKit

class ViewController: UIViewController,GIDSignInUIDelegate,GIDSignInDelegate,UIImagePickerControllerDelegate,UINavigationControllerDelegate {

   
    @IBOutlet weak var imageViewOutlet: UIImageView!


    override func viewDidLoad() {
        super.viewDidLoad()
        
        let content = FBSDKShareLinkContent()
        content.contentURL = URL(string: "https://google.com")
        
        let loginButton = FBSDKLoginButton()
        self.view.addSubview(loginButton)
        loginButton.center = self.view.center
        loginButton.readPermissions = [ "public_profile", "email", "user_friends" ]
        

        let button = FBSDKLikeControl()
        button.objectID = "https://www.facebook.com/FacebookDevelopers"
        self.view.addSubview(button)
        button.frame = CGRect(x: 100, y: 100, width: 100, height: 30)
       
        let shareButton = FBSDKShareButton()
        shareButton.shareContent = content
        self.view.addSubview(shareButton)
        shareButton.frame = CGRect(x: 100, y: 150, width: 100, height: 30)
        
        let sendButton = FBSDKSendButton()
        sendButton.shareContent = content
        self.view.addSubview(sendButton)
        sendButton.isHidden = false
        sendButton.isEnabled = true
        sendButton.frame = CGRect(x: 100, y: 200, width: 100, height: 30)
        
        var configureError: NSError?
        GGLContext.sharedInstance().configureWithError(&configureError)
        assert(configureError == nil, "Error configuring Google services: \(configureError)")

        GIDSignIn.sharedInstance().delegate = self
        GIDSignIn.sharedInstance().uiDelegate = self
        
        let googleButton = GIDSignInButton()
        view.addSubview(googleButton)
        googleButton.frame = CGRect(x: 100, y: 50, width: 100, height: 30)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()

    }
    
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        dismiss(animated: true, completion: nil)
    }
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : Any]){
        
        let image : UIImage = info[UIImagePickerControllerOriginalImage] as! UIImage
        
//        let photo = FBSDKSharePhoto()
//        photo.image = image
//        photo.isUserGenerated = true
//        let content = FBSDKSharePhotoContent()
//        content.photos = [photo]
        
        imageViewOutlet.image = image
        
        dismiss(animated: true, completion: nil)
    }
    func sign(_ signIn: GIDSignIn!, didSignInFor user: GIDGoogleUser!, withError error: Error!){
        if (error == nil) {
            // Perform any operations on signed in user here.
            let userId = user.userID                  // For client-side use only!
            let idToken = user.authentication.idToken // Safe to send to the server
            let fullName = user.profile.name
            let givenName = user.profile.givenName
            let familyName = user.profile.familyName
            let email = user.profile.email
            // ...
        } else {
            print("\(error.localizedDescription)")
        }        
    }

    func sign(inWillDispatch signIn: GIDSignIn!, error: Error!) {
    }
    
    func sign(_ signIn: GIDSignIn!,
              present viewController: UIViewController!) {
        self.present(viewController, animated: true, completion: nil)
    }
    
    func sign(_ signIn: GIDSignIn!,
              dismiss viewController: UIViewController!) {
        self.dismiss(animated: true, completion: nil)
    }

    @IBAction func imageButtonTapped(_ sender: UIButton) {
        
        let imagePickerController = UIImagePickerController()
        imagePickerController.allowsEditing = false
        imagePickerController.sourceType = .photoLibrary
        imagePickerController.delegate = self

        present(imagePickerController, animated: true, completion: nil)
        
    }

}

