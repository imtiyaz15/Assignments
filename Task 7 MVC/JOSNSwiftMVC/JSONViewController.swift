//
//  JSONViewController.swift
//  JOSNSwiftDemo
//
//  Created by Captain on 14/12/19.
//  Copyright © 2019 Sheldon. All rights reserved.
//

import UIKit

class JSONViewController: UIViewController {

    @IBOutlet var t1: UILabel!
    @IBOutlet var t2: UILabel!
   
    
    
    
    
        let urlString = "http://date.jsontest.com/"
    
    override func viewDidLoad() {
        super.viewDidLoad()
        jParsing()
        

        // Do any additional setup after loading the view.
    }
    
    func jParsing(){
        guard let url = URL(string: urlString) else {
            return }
        
        
        URLSession.shared.dataTask(with: url) { (data, response, error) in
            if error != nil {
                print("Error in urlSession:",error!.localizedDescription)
            }
            guard let data = data else { return }
            do {
                //Decode data
                let JSonData = try JSONDecoder().decode(DateTime.self, from: data)
                
                //Going back to main queue
                DispatchQueue.main.async {
                    self.t1.text = JSonData.date
                    self.t2.text = JSonData.time
                   // self.t3.text = String(JSonData.milliseconds_since_epoch)
                    print(JSonData)
                }
                
            }catch let err {
                print("Erro Decode data: ", err)
            }
            
            
        }.resume()
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
