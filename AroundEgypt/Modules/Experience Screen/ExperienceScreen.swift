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
        VStack {
            if let exp = viewModel.singleExperience {
                RemoteImage(singleExperience: exp)
                    .aspectRatio(contentMode: .fill)
                    .frame(maxWidth: .infinity, maxHeight: 291)
                    .padding(0)
                    .transition(.opacity)
            }
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
