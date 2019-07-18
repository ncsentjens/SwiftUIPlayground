//
//  ProfileViewViewModel.swift
//  NickSentjensSwiftUI
//
//  Created by Nick Sentjens on 2019-07-17.
//  Copyright © 2019 Nick Sentjens. All rights reserved.
//

import SwiftUI

// View model to display a single profile.
struct ProfileViewViewModel {
    let title: String
    let name: String
}

struct ProfileView : View {
    let viewModel: ProfileViewViewModel
    
    var body: some View {
        NavigationView {
            Text(self.viewModel.name)
        }
        .navigationBarTitle(self.viewModel.title)
    }
}

#if DEBUG
struct ProfileView_Previews : PreviewProvider {
    static var previews: some View {
        ProfileView(
            viewModel: ProfileViewViewModel(title: "Test Profile", name: "Test Name"))
    }
}
#endif
