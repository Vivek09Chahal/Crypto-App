//
//  localFileManager.swift
//  Crypto App
//
//  Created by Vivek Chahal on 3/30/25.
//

import Foundation
import SwiftUI

class localFileManager{
    
    static let instance = localFileManager()
    
    private init() { }
    
    func saveImages(image: UIImage, imageName: String, folderName: String){
        
        //create folder if it doesn't exist
        createFolder(folderName: folderName)
        
        guard
            let data = image.pngData(),
            let url = getURLForImage(imageName: imageName, folderName: folderName)
        else { return }
        
        do {
            try data.write(to: url)
        } catch let error {
            print("error saving image: image name: \(imageName), \(error.localizedDescription)")
        }
        
        
        
    }
    
    private func createFolder(folderName: String){
        
        guard let url = getURLForFolder(folderName: folderName) else { return }
        
        if !FileManager.default.fileExists(atPath: url.path)
        {
            do {
                try FileManager.default.createDirectory(at: url, withIntermediateDirectories: true, attributes: nil)
            } catch let error {
                print("error creating folder: \(error.localizedDescription)")
            }
        }
    }
    
    func getImages(imageName: String, folderName: String) -> UIImage? {
        guard let url = getURLForImage(imageName: imageName, folderName: folderName),
        FileManager.default.fileExists(atPath: url.path)
        else { return nil }
        
        return UIImage(contentsOfFile: url.path)
    }
    
    private func getURLForFolder(folderName: String) -> URL? {
        guard let url = FileManager.default.urls(for: .cachesDirectory, in: .userDomainMask).first else { return nil }
        return url.appendingPathComponent(folderName)
    }
    
    private func getURLForImage(imageName: String, folderName: String) -> URL? {
        guard let folderURL = getURLForFolder(folderName: folderName ) else { return nil }
        return folderURL.appendingPathComponent(imageName + ".png")
    }
    
}
