//
//  ViewControllerForTablle.swift
//  XMLParsing
//
//  Created by Brahmastra on 03/12/19.
//  Copyright © 2019 Trimelli Editori. All rights reserved.
//

import UIKit

struct jsonProduct:Decodable{
    
    var name:String
    var capital:String
}

class ViewControllerForTablle: UIViewController,UITableViewDataSource,UITableViewDelegate {
    
    @IBOutlet weak var table: UITableView!
    
    
    var arrData = [jsonProduct]()
    var name:[String] = []
    var capital:[String] = []
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {

        return name.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell  = UITableViewCell(style: .subtitle, reuseIdentifier: "cell")
        cell.textLabel?.text = name[indexPath.row]
        cell.detailTextLabel?.text = capital[indexPath.row]
        return cell
    }
    
   
    

  func getDatafromJson()
  {
    let url = URL(string: "https://restcountries.eu/rest/v2/all")
    // This uses to get info from API(URL JSON)
    URLSession.shared.dataTask(with: url!) { (data, response, error) in
        do{
            if error == nil{
                self.arrData = try JSONDecoder().decode([jsonProduct].self, from: data!)
                for arr in self.arrData{
                    self.name.append(arr.name)
                    self.capital.append(arr.capital)
                   
                }
                
                
            }
        }catch{
            print("Something is wrong in JSON URL")
        }
    }.resume()
    
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        getDatafromJson()
        table.isHidden = true
         print("Country",self.name, ":","Capital",self.capital )
        // Do any additional setup after loading the view.
    }
    
    @IBAction func click(_ sender: UIButton) {
        print("Button Clicked")
        table.isHidden = false
        self.table.reloadData()
        let alertController = UIAlertController(title: "Attention!!", message:
               "See the console", preferredStyle: .alert)
           alertController.addAction(UIAlertAction(title: "Dismiss", style: .default))

           self.present(alertController, animated: true, completion: nil)
        
        let VT  = MainViewController()
        VT.viewDidAppear(true)
    }
    
    
    @IBAction func sendDataButtonTapped(_ sender: UIButton) {
        let getdata = ViewController()
        getdata.senData()
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
