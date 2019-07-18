//
//  TeamViewViewModel.swift
//  NickSentjensSwiftUI
//
//  Created by Nick Sentjens on 2019-07-17.
//  Copyright © 2019 Nick Sentjens. All rights reserved.
//

import SwiftUI
import Combine

// The bindable object for the team view. 
final class TeamViewViewModel: BindableObject {
    let didChange = PassthroughSubject<TeamViewViewModel, Never>()
    
    let title: String
    
    var showFulltimeOnly: Bool {
        didSet {
            didChange.send(self)
        }
    }
    
    var segmentSelectedIndex: Int {
        didSet {
            didChange.send(self)
        }
    }
    
    var segmentColors: [(String, Color)] = [("White", .white), ("Blue", .blue), ("Green", .green)]
    
    var cellViewModels: [ProfileCellViewModel] {
        didSet {
            didChange.send(self)
        }
    }
    
    var backgroundColor: Color {
        return self.segmentColors[self.segmentSelectedIndex].1
    }
    
    init(title: String, showFulltimeOnly: Bool, cellViewModels: [ProfileCellViewModel]) {
        self.title = title
        self.showFulltimeOnly = showFulltimeOnly
        self.cellViewModels = cellViewModels
        self.segmentSelectedIndex = 0
    }
    
    // Returns the view models to be displayed based on the showFullTimeOnly flag.
    fileprivate func viewModelsToDisplay() -> [ProfileCellViewModel] {
        return self.cellViewModels.compactMap { (cellViewModel) -> ProfileCellViewModel? in
            guard !self.showFulltimeOnly || !cellViewModel.isCoop else {
                return nil
            }
            return cellViewModel
        }
    }
}

// The view that displays the entire team and toggle.
struct TeamView : View {
    @ObjectBinding var viewModel: TeamViewViewModel
    
    var body: some View {
        NavigationView {
            VStack {
                SegmentedControl(selection: $viewModel.segmentSelectedIndex) {
                    ForEach(0 ..< viewModel.segmentColors.count) { index in
                        Text(self.viewModel.segmentColors[index].0)
                            .tag(index)
                        
                    }
                }
                .padding()
                Toggle(isOn: $viewModel.showFulltimeOnly) {
                    Text("Show fulltime only")
                }
                .padding()
                List(self.viewModel.viewModelsToDisplay()) { cellViewModel in
                    NavigationLink(destination: ProfileView(viewModel: ProfileViewViewModel(title: "Profile View",
                                                                                            name: cellViewModel.name))) {
                                                                                                ProfileCell(viewModel: cellViewModel)
                    }
                }.colorMultiply(self.viewModel.backgroundColor)
            }
            .navigationBarTitle(Text(viewModel.title))
        }
    }
}

#if DEBUG
struct TeamView_Previews : PreviewProvider {
    static var previews: some View {
        TeamView(viewModel: TeamViewViewModel(title:"iOS Team",
                                              showFulltimeOnly: false,
                                              cellViewModels: [ProfileCellViewModel(name: "Nick Sentjens",
                                                                                    jobTitle: "iOS Developer",
                                                                                    isCoop: true),
                                                               ProfileCellViewModel(name: "Hailey Song",
                                                                                    jobTitle: "iOS Developer",
                                                                                    isCoop: false),
                                                               ProfileCellViewModel(name: "Milton Sawasaki",
                                                                                    jobTitle: "iOS Developer",
                                                                                    isCoop: false),
                                                               ProfileCellViewModel(name: "Eitan Khemlin",
                                                                                    jobTitle: "iOS Developer",
                                                                                    isCoop: true)]))
    }
}
#endif
