//
//  ViewController.swift
//  JsonDemo
//
//  Created by Brahmastra on 03/12/19.
//  Copyright © 2019 Brahmastra. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }

    @IBAction func onSendPostTapped(_ sender: UIButton) {
        print(">>>>>Send<<<<<")
        guard let url = URL(string: "https://jsonplaceholder.typicode.com/posts")  else {return}
        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        request.addValue("application/json", forHTTPHeaderField: "Content-type")
        let postDictonary = ["userId": "111", "id": "101", "title": "Hey there", "body": "Lets Chill guys"]
        do{
            let jsonBody = try JSONSerialization.data(withJSONObject: postDictonary, options: [] )
        request.httpBody = jsonBody
        } catch{}
        
        
        let session = URLSession.shared
        let task = session.dataTask(with: request) { (data, _, _) in
            guard let data = data else { return }
            do{
                let json = try JSONSerialization.jsonObject(with: data, options: [] )
                print(json)
            } catch {}
        }
        task.resume()
    }
    
    @IBAction func onGetUserTapped(_ sender: UIButton) {
        print(">>>>>Get<<<<<<<<")
    }
}

