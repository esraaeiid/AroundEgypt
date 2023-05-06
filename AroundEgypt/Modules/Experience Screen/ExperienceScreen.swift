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
    
    var body: some View {
        VStack {
            Image(systemName: "photo")
                .resizable()
                .foregroundColor(.yellow)
                .frame(width: 291, height: 291)
        }
    }
}

struct ExperienceScreen_Previews: PreviewProvider {
    static var previews: some View {
        ExperienceScreen()
    }
}
