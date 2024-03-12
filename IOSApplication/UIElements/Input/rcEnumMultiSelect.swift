//
//  rcEnumMultiSelect.swift
//  IOSApplication
//
//  Created by Joseph Simopoulos on 1/13/24.
//

import SwiftUI

struct rcEnumMultiSelect<EnumType: CaseIterable & RawRepresentable & Hashable>: View where EnumType.RawValue == String, EnumType.AllCases : RandomAccessCollection, EnumType.AllCases.Index : Hashable {
    
    @State private var selectedOptions: Set<EnumType> = []

    var body: some View {
        NavigationView {
                List {
                    ForEach(EnumType.allCases.indices, id: \.self) { index in
                        let option = EnumType.allCases[index]
                        Toggle(option.rawValue, isOn: Binding(
                            get: { selectedOptions.contains(option) },
                            set: { isSelected in
                                if isSelected {
                                    selectedOptions.insert(option)
                                } else {
                                    selectedOptions.remove(option)
                                }
                            }
                        ))
                    }

                Section(header: Text("Selected Options")) {
                    Text("Selected: \(selectedOptions.map { $0.rawValue }.joined(separator: ", "))")
                }
            }
            .navigationTitle("Multi-Select Dropdown")
        }
    }
}
