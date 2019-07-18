//
//  ProfileCellViewModel.swift
//  NickSentjensSwiftUI
//
//  Created by Nick Sentjens on 2019-07-17.
//  Copyright © 2019 Nick Sentjens. All rights reserved.
//

import SwiftUI

// The view model used for a single profile cell.
struct ProfileCellViewModel: Identifiable {
    let id = UUID()
    let name: String
    let jobTitle: String
    let isCoop: Bool
}

// The view used to display a user's profile.
struct ProfileCell : View {
    let viewModel: ProfileCellViewModel
    
    var body: some View {
        HStack(spacing: 20) {
            Image(systemName: "person.circle.fill")
                .resizable()
                .scaledToFit()
                .clipShape(Circle())
                .shadow(radius: 6)
                .frame(width: 80, height: 80)
            VStack(alignment: .leading,
                   spacing: 12) {
                    Text(self.viewModel.name)
                        .font(.title)
                        .bold()
                        .minimumScaleFactor(0.6)
                    Text(self.viewModel.jobTitle)
                        .font(.body)
            }
            Spacer()
            if (self.viewModel.isCoop) {
                Text("Co-op")
                    .font(.body)
            }
        }.padding()
        
    }
}

#if DEBUG
struct ProfileCell_Previews : PreviewProvider {
    static let viewModel = ProfileCellViewModel(name: "Nick Sentjens",
                                                jobTitle: "iOS Developer",
                                                isCoop: true)
    
    static var previews: some View {
        ProfileCell(viewModel: viewModel)
    }
}
#endif
