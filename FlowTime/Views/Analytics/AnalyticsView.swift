//
//  AnalyticsView.swift
//  FlowTime
//
//  Created by Matthew Seah on 4/2/21.
//

import SwiftUI

struct AnalyticsView: View {
    @Environment(\.managedObjectContext) private var viewContext
    @FetchRequest(
        entity: Flow.entity(),
        sortDescriptors: []
    ) var flows: FetchedResults<Flow>
    
    var body: some View {
        List {
            ForEach(flows) { (flow: Flow) in
                Text(flow.task ?? "unknown")
            }
        }
    }
}

struct AnalyticsView_Previews: PreviewProvider {
    static var previews: some View {
        AnalyticsView()
    }
}
