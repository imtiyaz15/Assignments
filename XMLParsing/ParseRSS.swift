//
//  ViewController.swift
//  Task6_XMLPasring_And_Json
//
//  Created by Brahmastra on 02/12/19.
//  Copyright © 2019 Brahmastra. All rights reserved.
//

import Foundation

struct RSS
{
    var title: String
    var author: String
    var category: String
    var description: String
    var pubdate: String
    var link: String
    var guid: String
    var image: String
}

class ParseRSS: NSObject, XMLParserDelegate
{
    private var myData: Data
    private var currentElementName = ""
    private var inItem = false
    private var inChannel = false
    private var item: RSS

    var ready = false

    var channel: RSS
    var items: [RSS]

    override init()
    {
        // Default values
        myData = "".data(using: .ascii)!
        channel = RSS(title: "", author: "", category: "", description: "", pubdate: "", link: "", guid: "", image: "")
        items = []
        item = channel
    }

    /// Sets the local data set for parsing.
    ///
    /// - Parameter data
    func setData(data: Data!) -> Void
    {
        if data == nil
        {
            return
        }

        myData = data
    }

    /// Runs the parsing process, returns at end. Please note that this function is synchronous, while internally asynchronous.
    func parse() -> Void
    {
        let parser = XMLParser(data: myData)
        parser.delegate = self
        parser.parse()
    }

    // -------------------------------------------------------------------------

    /// Terminate session
    ///
    /// - Parameter parser
    func parserDidEndDocument(_ parser: XMLParser)
    {
        ready = true
    }

    /// Start a new session
    ///
    /// - Parameter parser
    func parserDidStartDocument(_ parser: XMLParser)
    {
        ready = false
    }

    /// Terminate an element
    ///
    /// - Parameters:
    ///   - parser
    ///   - elementName: element name
    ///   - namespaceURI
    ///   - qName
    func parser(_ parser: XMLParser, didEndElement elementName: String, namespaceURI: String?, qualifiedName qName: String?)
    {
        currentElementName = elementName
        if elementName == "item"
        {
            inItem = false
            items.append(item)
            print("Printing Items title: \(item.title)")
            return
        }

        if elementName == "channel"
        {
            inChannel = false
        }
    }

    /// Starts an element
    ///
    /// - Parameters:
    ///   - parser
    ///   - elementName: element name
    ///   - namespaceURI
    ///   - qName
    ///   - attributeDict
    func parser(_ parser: XMLParser, didStartElement elementName: String, namespaceURI: String?, qualifiedName qName: String?, attributes attributeDict: [String : String] = [:])
    {
        currentElementName = elementName
        if elementName == "item"
        {
            inItem = true
            item = RSS(title: "", author: "", category: "", description: "", pubdate: "", link: "", guid: "", image: "")
        }
    }

    /// Collects data from CDATA blocks
    ///
    /// - Parameters:
    ///   - parser
    ///   - CDATABlock: Data block
    func parser(_ parser: XMLParser, foundCDATA CDATABlock: Data)
    {
        let s: String = String(data: CDATABlock, encoding: .utf8)!

        if !inItem
        {
            // Not in item, store data to channel
            switch currentElementName.lowercased()
            {
            case "title":
                channel.title = s
            case "description":
                channel.description = s
            default:
                break
            }
            return
        }

        switch currentElementName.lowercased()
        {
        case "title":
            item.title = s
        case "author":
            item.author = s
        case "category":
            item.category = s
        case "description":
            item.description = s
        default:
            break
        }
    }

    /// Collects other data
    ///
    /// - Parameters:
    ///   - parser
    ///   - string: Incoming partial data
    func parser(_ parser: XMLParser, foundCharacters string: String)
    {
        if !inItem
        {
            // Not in item, store data to channel
            switch currentElementName.lowercased()
            {
            case "link":
                channel.link += string.trimmingCharacters(in: CharacterSet.whitespacesAndNewlines)
            case "lastbuilddate":
                channel.pubdate += string.trimmingCharacters(in: CharacterSet.whitespacesAndNewlines)
            case "category":
                channel.category += string.trimmingCharacters(in: CharacterSet.whitespacesAndNewlines)
            case "url":
                channel.image += string.trimmingCharacters(in: CharacterSet.whitespacesAndNewlines)
            default:
                break
            }
            return
        }

        switch currentElementName.lowercased()
        {
        case "pubdate":
            item.pubdate += string.trimmingCharacters(in: CharacterSet.whitespacesAndNewlines)
        case "link":
            item.link += string.trimmingCharacters(in: CharacterSet.whitespacesAndNewlines)
        case "guid":
            item.guid += string.trimmingCharacters(in: CharacterSet.whitespacesAndNewlines)
        default:
            break
        }
    }
}
