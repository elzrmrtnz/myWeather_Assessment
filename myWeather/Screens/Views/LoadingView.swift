//
//  LoadingView.swift
//  MoviesApp
//
//  Created by Mohammad Azam on 7/25/20.
//  Copyright © 2020 Mohammad Azam. All rights reserved.
//

import SwiftUI

struct LoadingView: View {
    var body: some View {
        ProgressView()
            .progressViewStyle(CircularProgressViewStyle(tint: .white))
            .frame(maxWidth: .infinity, maxHeight: .infinity)
    }
}

struct LoadingView_Previews: PreviewProvider {
    static var previews: some View {
        LoadingView()
    }
}
