//
//  neworkingManager.swift
//  Crypto App
//
//  Created by Vivek Chahal on 3/30/25.
//

import Foundation
import Combine

class networkManager {
    

    enum networkingError: LocalizedError{
        case badURLResponse(url: URL)
        case unKnown
        
        var errorDescription: String?{
            switch self {
            case .badURLResponse(url: let url): return "[🔥] Bad Response from URL. \(url)"
            case .unKnown: return "[⚠️] Unknown error occured."
            }
        }
    }
        
    static func download(url: URL) -> AnyPublisher<Data, Error> {
        return URLSession.shared.dataTaskPublisher(for: url)
            .subscribe(on: DispatchQueue.global(qos: .default))
            .tryMap ({ try handelURLResponse(output: $0, url: url) })
            .receive(on: DispatchQueue.main)
            .eraseToAnyPublisher()
    }
    
    static func handelURLResponse(output: URLSession.DataTaskPublisher.Output, url: URL) throws -> Data {
        guard let response = output.response as? HTTPURLResponse,
                response.statusCode >= 200 && response.statusCode < 300
        else {
            throw networkingError.badURLResponse(url: url )
        }
        return output.data
    }
    
    static func handelCompletion(completion: Subscribers.Completion<Error>) {
            switch completion{
            case .finished:
                break
            case .failure(let error):
                print("error:\(error.localizedDescription)")
            }
    }
    
}
