//
//  Extenstions.swift
//  SnowSeeker
//
//  Created by Thai Nguyen on 1/12/20.
//  Copyright © 2020 Thai Nguyen. All rights reserved.
//

import Foundation
import SwiftUI

extension View {
    func phoneOnlyStackNavigationView() -> some View {
        if UIDevice.current.userInterfaceIdiom == .phone {
            return AnyView(self.navigationViewStyle(StackNavigationViewStyle()))
        } else {
            return AnyView(self)
        }
    }
}
