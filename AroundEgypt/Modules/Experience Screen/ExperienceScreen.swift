//
//  ExperienceScreen.swift
//  AroundEgypt
//
//  Created by Esraa Eid on 05/05/2023.
//

import SwiftUI

struct ExperienceScreen: View {
    
    //MARK: Vars
    @StateObject var viewModel = ExperienceViewModel(useCase: ExperienceUseCase())
    
    //        viewModel?.singleExperienceRequest(with: "94a6e522-0e6a-480d-b70b-9bffd0068f11")

    var body: some View {
        VStack {
            Image(systemName: "photo")
                .resizable()
                .foregroundColor(.yellow)
                .frame(maxWidth: .infinity, maxHeight: 291)
                .padding(0)
            Spacer()
        }
    }
}

struct ExperienceScreen_Previews: PreviewProvider {
    static var previews: some View {
        ExperienceScreen()
    }
}
