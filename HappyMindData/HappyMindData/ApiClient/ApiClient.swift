//
//  ApiClient.swift
//  HappyMindData
//
//  Created by Carlos Pava on 26/09/20.
//  Copyright © 2020 Carlos Pava. All rights reserved.
//

import Foundation

public final class ApiClient {

    public init() {

    }

    public func getSong(completion: @escaping(_ result: Result<Data, Error>) -> Void) {
        if let audioUrl = URL(string: "https://a.clyp.it/m5ez3noz.mp3") {
            URLSession.shared.downloadTask(with: audioUrl) { location, response, error in
                guard let location = location, error == nil else { return }
                do {
                    print("song")
                } catch {
                    print(error)
                }
            }.resume()
        }
    }

    public func getSongs(completion: @escaping(_ result: Result<URL, Error>) -> Void) {
        if let audioUrl = URL(string: "https://a.clyp.it/m5ez3noz.mp3") {

            // then lets create your document folder url
            let documentsDirectoryURL = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first!

            // lets create your destination file url
            let destinationUrl = documentsDirectoryURL.appendingPathComponent(audioUrl.lastPathComponent)
            print(destinationUrl)

            // to check if it exists before downloading it
            if FileManager.default.fileExists(atPath: destinationUrl.path) {
                print("The file already exists at path")
                let url = self.getFile(url: destinationUrl)
                completion(.success(url))
                // if the file doesn't exist
            } else {

                // you can use NSURLSession.sharedSession to download the data asynchronously
                URLSession.shared.downloadTask(with: audioUrl, completionHandler: { (location, response, error) -> Void in
                    guard let location = location, error == nil else { return }
                    do {
                        // after downloading your file you need to move it to your destination url
                        try FileManager.default.moveItem(at: location, to: destinationUrl)

                    } catch let error as NSError {
                        print(error.localizedDescription)
                        completion(.failure(error))
                    }
                }).resume()
            }
        }
    }

    func getFile(url: URL) -> URL {
        let documentsDirectoryURL = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first!

        // lets create your destination file url
        return documentsDirectoryURL.appendingPathComponent(url.lastPathComponent)
    }
}
