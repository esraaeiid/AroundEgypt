//
//  ImageLoader.swift
//  AroundEgypt
//
//  Created by Esraa Eid on 06/05/2023.
//

import Foundation
import UIKit
import Combine

final class ImageLoader {
    @Published var image: UIImage? = nil
    @Published var isLoading: Bool = false
    var cancellables = Set<AnyCancellable>()
    let manager: PhotoCacheManager = PhotoCacheManager.shared
    let urlString: String
    let photoID: String

    init(url: String, photoID: String) {
        self.urlString = url
        self.photoID = photoID
        getImage()
    }

    private func getImage() {
        if let savedImage = manager.retrieveImage(forKey: photoID) {
            image = savedImage
        } else {
            downloadImage()
        }
    }
    
    
    
    
    private func downloadImage() {
        isLoading = true
        guard let url = URL(string: urlString) else {
            isLoading = false
            return
        }
        
        URLSession.shared.dataTaskPublisher(for: url)
            .map { (data, response) -> UIImage? in
                return UIImage(data: data)
            }
            .receive(on: DispatchQueue.main)
            .sink { [weak self] _ in
                guard let self = self else { return }
                
                self.isLoading = false
            } receiveValue: { [weak self] returnData in
                guard let self = self else { return }
                
                self.image = returnData
                if let returnData = returnData {
                    self.manager.store(image: returnData, forKey: self.photoID)
                }
            }
            .store(in: &cancellables)
    }
}

