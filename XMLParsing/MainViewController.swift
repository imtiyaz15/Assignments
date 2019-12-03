//
//  ViewController.swift
//  Task6_XMLPasring_And_Json
//
//  Created by Brahmastra on 02/12/19.
//  Copyright © 2019 Brahmastra. All rights reserved.
//

import UIKit

class MainViewController: UIViewController
{
    
    override func viewDidLoad()
    {
        super.viewDidLoad()

    }

    override func viewDidAppear(_ animated: Bool)
    {
        // Load data
        loadData()
    }

    @IBAction func btnRefreshPressed(_ sender: Any)
    {
        // Load data
        loadData()
        let VT  = ViewControllerForTablle()
        VT.getDatafromJson()
    }

     func loadData() -> Void
    {
        // Make asynchronous web request and handle replies
        let url = "https://www.lavocecastiglione.it/x5short.rss"
        let request = URLRequest(url: URL(string: url)!)
        let session = URLSession.shared.dataTask(with: request)
        {
            (data, _, error) in

            // Handle errors
            if error != nil
            {
                // Show error message
                return
            }

            guard let data = data else
            {
                // Data error, show message
                return
            }

            // Convert data to string
            var s: String = String(data: data, encoding: .ascii)!

            // Make XML conforming to all standards: Convert LF to CR
            s = s.replacingOccurrences(of: "\r", with: "\n")

            // Parse XML
            let p = ParseRSS()
            p.setData(data: data)
            p.parse()

            // Elaborate data
            print(p.channel)
            print(p.items)
        }

        // Run!
        session.resume()
    }
}
