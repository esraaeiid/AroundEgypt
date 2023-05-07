//
//  RemoteImage.swift
//  AroundEgypt
//
//  Created by Alaa Eid on 08/05/2023.
//

import SwiftUI
import Combine

struct RemoteImage: View {
    
    

    
    private enum LoadState {
        case loading, success, failure
    }

    private class Loader: ObservableObject {
        var loadedImage: UIImage?
        var state = LoadState.loading
        var imageLoader: ImageLoader?
        var cancellable: [AnyCancellable] = []

        init(singleExperience: ExperienceModel) {
            
            switch singleExperience.data {
            case .experienceDetails(let experience):
                if let url = experience.coverPhoto,
                   let experienceID = experience.id {
                    imageLoader = ImageLoader(url: url,
                                              photoID: experienceID)
                }
            case .int(_):
                break
            case .none:
                break
            }

            guard imageLoader != nil else {
                return
            }

            imageLoader?.$image.sink { [weak self] img in
                guard let self = self else { return }

                if img != nil {
                    self.loadedImage = img
                    self.imageLoader = nil
                    self.state = .success
                } else {
                    self.state = .failure
                }
                
                DispatchQueue.main.async {
                    self.objectWillChange.send()
                }

            }.store(in: &cancellable)
        }
    }

    @StateObject private var loader: Loader
    var loading: Image
    var failure: Image

    var body: some View {
        selectImage()
            .resizable()
    }

    init(singleExperience: ExperienceModel, loading: Image = Image(systemName: "photo"), failure: Image = Image(systemName: "multiply.circle")) {
        _loader = StateObject(wrappedValue: Loader(singleExperience: singleExperience))
        self.loading = loading
        self.failure = failure
    }

    private func selectImage() -> Image {
        switch loader.state {
        case .loading:
            return loading
        case .failure:
            return failure
        default:
            if let image = loader.loadedImage {
                return Image(uiImage: image)
            } else {
                return failure
            }
        }
    }
}
