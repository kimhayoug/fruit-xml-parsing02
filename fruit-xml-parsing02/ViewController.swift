//
//  ViewController.swift
//  fruit-xml-parsing02
//
//  Created by D7703_23 on 2018. 9. 17..
//  Copyright © 2018년 D7703_23. All rights reserved.
//

import UIKit

class ViewController:UIViewController, XMLParserDelegate{

    @IBOutlet weak var myTable: UITableView!
    var elemants : [[String:String]] = [[:]]
    var item : [String:String] = [:]
    var currentElement = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()
    // Do any additional setup after loading the view, typically from a nib.
    //   if let path = Bundle.main.url(forResource: "Fruit", withExtension: "xml") {
    //       if let myparser  = XMLParser(contentsOf: path) {
                //XMLparse
    //    myparser.delegate = self
                
    //    if myparser.parse(){
    //      print("parsing succed")
    //  }else{
    //    print("parsing failed!")
    //         }
    //    }else{
    //      print("parser nil")
    //}
    //}else{
    //    print("XML file not found!")
    //}
    let strURL = "http://apl.androichive.info/pizza/?format=xml"
        if NSURL(string: strURL) != nil {
        if let parser = XMLParser(contentsOf: NSURL(string: strURL)! as URL) {
               parser.delegate = self
    
            if parser.parse() {
               print("parsing success")
               print("elements")
                } else {
               print("parsing fail")
                           }
            
                        }
                    }

    }

    func parser(_ parser: XMLParser, didStartElement elementName: String, namespaceURI: String?, qualifiedName qName: String?, attributes attributeDict: [String : String] = [:]) {
        currentElement = elementName
        print("currentElement = \(currentElement)")
    }
    func parser(_ parser: XMLParser, foundCharacters string: String) {
        let data = string.trimmingCharacters(in: CharacterSet.whitespacesAndNewlines)
        if !data.isEmpty{
            item["name"] = data
        }
    }
    func parser(_ parser: XMLParser, didEndElement elementName: String, namespaceURI: String?, qualifiedName qName: String?) {
        if elementName == "item"{
           elemants.append(item)
        }
}
    func myTable(_ tableview: UITableView, numberOfRowsInSection section: Int) -> Int {
        return elemants.count
        
    }
    func myTable(_tableview: UITableView, cellForRomAt indexPath: IndexPath) -> UITableViewCell {
        let cell = myTable.dequeueReusableCell(withIdentifier: "re", for: IndexPath)
        let myItem = elemants(IndexPath.row)
        
        cell.textLable?.text = "Name:" + myItem["name"]!
        cell.detailTextLable?.text = "Cost:" + myItem["cost"]!
        return
    }

}
