//
//  Feature Displays.swift
//  Happy Kids Feature
//
//  Created by Yusuf Alp Tigin Gün on 13.02.2023.
//

import Foundation
import SwiftUI
import UIKit
import PDFKit

struct Objects_Display: View {
    
    @Environment(\.presentationMode) var mode: Binding<PresentationMode>
    @EnvironmentObject var hkViewModel: HKViewModel
    @StateObject var shareSheetController: ShareSheetController = ShareSheetController()
    let pageChoice: String
    
    var body: some View {
        VStack(spacing: screenHeight * 0.01) {
            if pageChoice == "Emzirme" && !hkViewModel.nursingObjects.isEmpty { Nursing_Objects_Display() }
            else if pageChoice == "Biberon" && !hkViewModel.bottleObjects.isEmpty { Bottle_Objects_Display() }
            else if pageChoice == "Mama" && !hkViewModel.foodObjects.isEmpty { Food_Objects_Display() }
            else if pageChoice == "Süt Sağma" && !hkViewModel.milkingObjects.isEmpty { Milking_Objects_Display() }
            else if pageChoice == "Bebek Bezi" && !hkViewModel.diaperObjects.isEmpty { Diaper_Objects_Display() }
            else if pageChoice == "Uyku" && !hkViewModel.sleepObjects.isEmpty { Sleep_Objects_Display() }
            else if pageChoice == "Gezinti" && !hkViewModel.travelObjects.isEmpty { Travel_Objects_Display() }
            else if pageChoice == "Banyo" && !hkViewModel.bathObjects.isEmpty { Bath_Objects_Display() }
            else if (pageChoice == "Doktor" || pageChoice == "Aşı" || pageChoice == "Ateş" || pageChoice == "Hastalık" || pageChoice == "İlaç") &&
                    checkIfHealthObjectExistsForPage(healthPage: pageChoice, healthObjects: hkViewModel.healthObjects)
                    { Health_Objects_Display(healthPage: pageChoice) }
            else { Empty_Display() }
        }.navigationTitle(pageChoice).navigationBarBackButtonHidden(true).navigationBarTitleDisplayMode(.inline)
            /* iOS 16.0+
             .toolbarBackground(.visible, for: .navigationBar)
             .toolbarBackground(Color.navBarColor, for: .navigationBar)
             .toolbarColorScheme(.dark, for: .navigationBar)
            */
            .toolbar {
                ToolbarItem(placement: .navigationBarTrailing) {
                    Group {
                        if #available(iOS 16.0, *) { ShareLink("Export PDF", item: render()) }
                        else {
                            Button(action: {
                                exportPDF(content: { PDF_Displays(pageName: pageChoice).environmentObject(hkViewModel) },
                                pageChoice: pageChoice,
                                completion: { status, url in
                                    if let url = url, status {
                                        shareSheetController.PDFUrl = url
                                        shareSheetController.showShareSheet.toggle()
                                    }
                                    else { print("PDF oluşturulamadı.") }
                                })}) { Image(systemName: "square.and.arrow.up") }
                        }
                    }.foregroundColor(.white)
                }
                ToolbarItem(placement: .navigationBarLeading){
                    Button(action: { mode.wrappedValue.dismiss() }) { Image(systemName: "chevron.backward").foregroundColor(.white) } }
            }
            .sheet(isPresented: $shareSheetController.showShareSheet) {
                shareSheetController.PDFUrl = nil
            } content: { if let PDFUrl = shareSheetController.PDFUrl { ShareSheet(urls: [PDFUrl]) } }
    }
    
    @available(iOS 16.0, *)
    func render() -> URL {
        
        let renderer = ImageRenderer(content: PDF_Displays(pageName: pageChoice).environmentObject(hkViewModel))
        let url = URL.documentsDirectory.appending(path: "\(pageChoice).pdf")
    
        renderer.render { size, context in
            var box = CGRect(x: 0, y: 0, width: size.width, height: size.height)
            guard let pdf = CGContext(url as CFURL, mediaBox: &box, nil) else { return }
            pdf.beginPDFPage(nil)
            context(pdf)
            pdf.endPDFPage()
            pdf.closePDF()
        }
        return url
    }
}
