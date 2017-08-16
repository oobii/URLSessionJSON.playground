import UIKit
import Foundation
import PlaygroundSupport

// for async code n Playground
PlaygroundPage.current.needsIndefiniteExecution = true

// To remove "Failed to obtain sandbox extension for path=
// Playgrounds are sandboxed
URLCache.shared = URLCache(memoryCapacity: 0, diskCapacity: 0, diskPath: nil)

if let url = NSURL(string: "https://itunes.apple.com/search?term=blue+system&limit=3") {
    
    let session = URLSession.shared
    let dataTask = session.dataTask(with: url as URL,completionHandler: {(data,_,_) in
        defer {
            
        }
        if let data = data, let string = String(data: data, encoding: String.Encoding.utf8) {
            print(string)
            
            // Working with JSON in Swift https://developer.apple.com/swift/blog/?id=37
            
            let json = try? JSONSerialization.jsonObject(with: data, options: [])
            if let dict = json as? [String : Any] {
                dict
                if let numRows = dict["resultCount"] as? Int  {
                    print("Number of Songs: \(numRows)")
                    numRows
                    if let songs = dict["results"] as? Array<Any> {
                        for songInfo in songs {
                            if let songInfo = songInfo as? [String : Any] {
                                if let trackName = songInfo["trackName"] as? String {
                                    print("Track Name : \(trackName)")
                                }
                            }
                        }
                    }
                }
            }
        }
    }
    )
    
    dataTask.resume()
}

