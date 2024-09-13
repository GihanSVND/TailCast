//
//  PDFViewer.swift
//  TailCast
//
//  Created by Gihan Savinda on 2024-09-12.
//

import SwiftUI
import Firebase
import FirebaseStorage
import PDFKit

struct PDFViewerView: UIViewRepresentable {
    let url: URL

    func makeUIView(context: Context) -> PDFView {
        let pdfView = PDFView()
        pdfView.document = PDFDocument(url: url)
        pdfView.autoScales = true
        return pdfView
    }

    func updateUIView(_ uiView: PDFView, context: Context) {}
}


