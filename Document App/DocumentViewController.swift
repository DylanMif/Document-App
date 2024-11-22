//
//  DocumentViewController.swift
//  Document App
//
//  Created by Dylan MIFTARI on 11/18/24.
//

import UIKit
import QuickLook


class DocumentViewController: UIViewController, QLPreviewControllerDataSource {
    var documentURL: URL?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let previewController = QLPreviewController()
        previewController.dataSource = self
        navigationController?.pushViewController(previewController, animated: true)
        // Do any additional setup after loading the view.
    }
    
    func numberOfPreviewItems(in controller: QLPreviewController) -> Int {
        return 1
    }
    
    func previewController(_ controller: QLPreviewController, previewItemAt index: Int) -> QLPreviewItem {
        return documentURL! as QLPreviewItem
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
