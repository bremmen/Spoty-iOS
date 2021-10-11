//
//  HomeBuilder.swift
//  Spoty
//
//  Created by Bruno Fontes on 3/10/21.
//

import Foundation

struct HomeBuilder {
    static func build() -> HomeViewController {
        let viewModel: HomeViewModel = HomeViewModel()
        let controller: HomeViewController = HomeViewController(viewModel: viewModel)

        return controller
    }
}
