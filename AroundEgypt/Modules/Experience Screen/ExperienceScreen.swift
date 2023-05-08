//
//  ExperienceScreen.swift
//  AroundEgypt
//
//  Created by Esraa Eid on 05/05/2023.
//

import SwiftUI

class ExperienceModelEnvironmentObject: ObservableObject {
    
    
    @Published  var experienceID: String
    
    init(experienceID: String){
        self.experienceID = experienceID
    }
}

struct ExperienceScreen: View {
    
    //MARK: Vars    
    @StateObject var viewModel = ExperienceViewModel(useCase: ExperienceUseCase())
    
    @ObservedObject var model = ExperienceModelEnvironmentObject(experienceID: "")


    var body: some View {
        VStack(alignment: .center, spacing: 16) {
            
            if let exp = viewModel.singleExperience {
                RemoteImage(singleExperience: exp)
                    .frame(maxWidth: .infinity, maxHeight: 250)
                    .padding(0)
                    .transition(.opacity)
                    .clipped()
            }
            
            HStack(alignment: .top, spacing: 10) {
                
                VStack(alignment: .leading, spacing: 0){
                    Text(viewModel.title)
                        .font(.headline)
                        .lineLimit(1)
                    Text(viewModel.location)
                        .font(.subheadline)
                        .lineLimit(1)
                }
                
                Spacer()
                
                Button {
                } label: {
                    Image(uiImage: UIImage(named: "share") ?? UIImage())
                }
                
                Button {
                    viewModel.likeExperienceRequest(with: model.experienceID)
                } label: {
                    Image(uiImage: UIImage(named: "heartEmpty") ?? UIImage())
                }
                
                Text(viewModel.noOfLikes)
                    .font(.headline)
                    .lineLimit(1)
                
            }
            .padding([.horizontal, .bottom])
            
            
            VStack(alignment: .leading, spacing: 0){
                Text("Description")
                    .font(.headline)
                    .lineLimit(1)
                Text(viewModel.description)
                    .font(.subheadline)
                    .multilineTextAlignment(.leading)
            }


                
            .padding([.horizontal, .bottom])
            Spacer()
        }
        .environmentObject(viewModel)
        .onAppear {
            viewModel.singleExperienceRequest(with: model.experienceID)
        }
    }
}

struct ExperienceScreen_Previews: PreviewProvider {
    static var previews: some View {
        ExperienceScreen()
    }
}
