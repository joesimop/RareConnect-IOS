//
//  rcDropdownSelect.swift
//  IOSApplication
//
//  Created by Joseph Simopoulos on 1/13/24.
//

import SwiftUI

struct rcDropdownSelect<EnumType: CaseIterable & RawRepresentable & Equatable & Hashable>: View where EnumType.RawValue == String, EnumType.AllCases : RandomAccessCollection{
    
    @Binding var selectedOption: EnumType

    var body: some View {
        VStack {
            Picker("Select Option", selection: $selectedOption) {
                ForEach(EnumType.allCases, id: \.self) { option in
                    Text(option.rawValue).tag(option)
                }
            }
            .pickerStyle(MenuPickerStyle())
            .padding()
        }
    }
}
