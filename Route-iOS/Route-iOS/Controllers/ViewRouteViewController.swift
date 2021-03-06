//
//  ViewRouteViewController.swift
//  Route-iOS
//
//  Created by matthew vastarelli on 4/7/19.
//  Copyright © 2019 Vastarelli, Matthew P. All rights reserved.
//

import UIKit
import Firebase
import AVFoundation

class ViewRouteViewController: UIViewController {

    // firebase auth handler
    var handle: AuthStateDidChangeListenerHandle?
    var isSignedIn = false
    var userEmail = ""
    var container = Array<Any>()
    var user = User(fName: "", lName: "")
    //spech synth
    let synth = AVSpeechSynthesizer()
    var utterance = AVSpeechUtterance(string: "")
    
    @IBOutlet weak var attributeLabel: UILabel!
    @IBOutlet weak var locationLabel: UILabel!
    @IBOutlet weak var speedLabel: UILabel!
    @IBOutlet weak var typeLabel: UILabel!
    @IBOutlet weak var terainLabel: UILabel!
    @IBOutlet weak var descriptionLabel: UILabel!
    @IBOutlet weak var titleLabel: UILabel!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.setLabels()
        print("size", self.container.count)
        // Do any additional setup after loading the view.
    }
    
    func setLabels() {
        let route = container[0] as! RoutePost
        
        self.descriptionLabel.text = route.getPostBody()
        self.titleLabel.text = route.getTitle()
        self.speedLabel.text = route.getRoute().getTrafficSpeed()
        self.locationLabel.text = route.getRoute().getLocationType()
        self.typeLabel.text = route.getRoute().getActivityType()
        self.attributeLabel.text = route.getRoute().getAttributes().joined(separator: ", ")
        self.terainLabel.text = route.getRoute().getTerain()
    }
    
    @IBAction func saveRoute(_ sender: Any) {
        if isSignedIn {
            let route = container[0] as! RoutePost
            //self.getUser(Email: self.userEmail)

            self.user.addSavedRoute(id: route.getID())
            // save the update
            self.user.update()
            
        }
        else {
            print("")
        }
        
    }
    // speak the text from the post
    @IBAction func speakPost(_ sender: Any) {
        let route = container[0] as! RoutePost
        
        let title = route.getTitle()
        let des = route.getPostBody()
        let loc = route.getRoute().getLocationType()
        let ter = route.getRoute().getTerain()
        let speed = route.getRoute().getTrafficSpeed()
        let actType = route.getRoute().getActivityType()
        let attr = route.getRoute().getAttributes().joined(separator: ", and")
        
        let postString = title + des + "route took place in a " + loc + "environment" + ter + " this route was a " + actType + " route where The traffic was"
            + speed + " and the current route has" + attr
        
        utterance = AVSpeechUtterance(string: postString)
        utterance.rate = 0.37
        synth.speak(utterance)
    }
    
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        Auth.auth().removeStateDidChangeListener(handle!)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        handle = Auth.auth().addStateDidChangeListener { (auth, user) in
            if ((user) != nil) {
                let email = user?.email
                
                if !email!.isEmpty {
                    self.userEmail = email as! String
                    // get the user before the view appears
                    self.getUser()
                }
                
                self.isSignedIn = true
            }
            else {
                self.isSignedIn = false
                print("not signed in")
            }
        }
    }
    
    func getUser() {
        //  get data
        let db = Firestore.firestore()
        
        let colRef = db.collection("Users")
        _ = colRef.getDocuments()
        {
            (querySnapshot, err) in
            
            if let err = err
            {
                print("Error getting documents: \(err)");
            }
            else
            {
                //for all the documents
                for document in querySnapshot!.documents {
                    
                    //get data
                    let data = document.data() // main document data
                    let email = data["email"] as! String
                    let fName = data["first name"] as! String
                    let lName = data["last name"] as! String
                    
                    let myRoutes = data["my routes"] as! Array<String>
                    let savedRoutes = data["saved routes"] as! Array<String>
                    
                    
                    if email == self.userEmail
                    {
                        self.user.setFirstName(name: fName)
                        self.user.setLastName(name: lName)
                        self.user.setMyRoutes(routes: myRoutes)
                        self.user.setEmail(email: email)
                        self.user.setMySavedRoutes(savedRoutes: savedRoutes)
                        self.user.setID(id: document.documentID)
                    }
                }
            }
        }
    }
}
