//
//  DocumentTableViewController.swift
//  Document App
//
//  Created by Dylan MIFTARI on 11/18/24.
//

import UIKit
import QuickLook


extension Int {
    func formattedSize() -> String {
        let formatter:ByteCountFormatter = ByteCountFormatter()
        return formatter.string(fromByteCount: Int64(self))
    }
}

extension DocumentTableViewController: QLPreviewControllerDataSource {

    // Cette méthode est utilisée pour définir combien d'éléments à prévisualiser.
    func numberOfPreviewItems(in controller: QLPreviewController) -> Int {
        return 1
    }

    // Cette méthode fournit l'élément à prévisualiser (ici, l'URL du fichier).
    func previewController(_ controller: QLPreviewController, previewItemAt index: Int) -> QLPreviewItem {
        // On retourne l'URL du fichier sélectionné
        let selectedDocument = DocumentTableViewController.documentsFiles[tableView.indexPathForSelectedRow!.row]
        return selectedDocument.url as QLPreviewItem
    }
}

class DocumentTableViewController: UITableViewController {
    
    // A mettre dans votre DocumentTableViewController
    func listFileInBundle() -> [DocumentFile] {
            // Init du FileManager (classe permettant de
            let fm = FileManager.default
            // Chargement du chemin du bundle principal
            let path = Bundle.main.resourcePath!
            // Récupération des fichiers du bundle
            let items = try! fm.contentsOfDirectory(atPath: path)
            
            // Initialisation de la liste des DocumentsFiles
            var documentListBundle = [DocumentFile]()
        
            // Parcours de tous les fichiers récupérés
            for item in items {
                // Pn séléctionne les images
                if !item.hasSuffix("DS_Store") && item.hasSuffix(".jpg") {
                    // Calcul du chemin du fichier
                    let currentUrl = URL(fileURLWithPath: path + "/" + item)
                    // Récupération des différentes informations du fichier (taille, nom)
                    let resourcesValues = try! currentUrl.resourceValues(forKeys: [.contentTypeKey, .nameKey, .fileSizeKey])
                       
                    // On ajoute le DocumentFile à notre liste
                    documentListBundle.append(DocumentFile(
                        title: resourcesValues.name!,
                        size: resourcesValues.fileSize ?? 0,
                        imageName: item,
                        url: currentUrl,
                        type: resourcesValues.contentType!.description)
                    )
                }
            }
            // On retourne la liste
            return documentListBundle
        }
    
    func testFile() -> [DocumentFile] {
        return [
            DocumentFile(title: "Document 1", size: 100, imageName: nil, url: URL(string: "https://www.apple.com")!, type: "text/plain"),
            DocumentFile(title: "Document 2", size: 200, imageName: nil, url: URL(string: "https://www.apple.com")!, type: "text/plain"),
            DocumentFile(title: "Document 3", size: 300, imageName: nil, url: URL(string: "https://www.apple.com")!, type: "text/plain"),
            DocumentFile(title: "Document 4", size: 400, imageName: nil, url: URL(string: "https://www.apple.com")!, type: "text/plain"),
            DocumentFile(title: "Document 5", size: 500, imageName: nil, url: URL(string: "https://www.apple.com")!, type: "text/plain"),
            DocumentFile(title: "Document 6", size: 600, imageName: nil, url: URL(string: "https://www.apple.com")!, type: "text/plain"),
            DocumentFile(title: "Document 7", size: 700, imageName: nil, url: URL(string: "https://www.apple.com")!, type: "text/plain"),
            DocumentFile(title: "Document 8", size: 800, imageName: nil, url: URL(string: "https://www.apple.com")!, type: "text/plain"),
            DocumentFile(title: "Document 9", size: 900, imageName: nil, url: URL(string: "https://www.apple.com")!, type: "text/plain"),
            DocumentFile(title: "Document 10", size: 1000, imageName: nil, url: URL(string: "https://www.apple.com")!, type: "text/plain"),
        ]
    }
    
    
    struct DocumentFile {
        var title: String
        var size: Int
        var imageName: String? = nil
        var url: URL
        var type: String
    }
    
    public static var documentsFiles: [DocumentFile] = [];
    
    @objc public func addDocument() {
        print("koukou")
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        DocumentTableViewController.documentsFiles = self.listFileInBundle();
        
        navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .add, target: self, action: #selector(addDocument))

        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return DocumentTableViewController.documentsFiles.count
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "DocumentCell", for: indexPath)
     
        let document = DocumentTableViewController.documentsFiles[indexPath.row]
       
        cell.textLabel?.text = document.title
        cell.detailTextLabel?.text = "Size: \(document.size.formattedSize())"
            
        if let imageName = document.imageName {
            cell.imageView?.image = UIImage(named: imageName)
        } else {
            cell.imageView?.image = nil
        }
            
        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
           // Initialiser un QLPreviewController
            let previewController = QLPreviewController()

            // Définir le delegate et la source de données
            previewController.dataSource = self

            // Passer l'URL du fichier à prévisualiser
            previewController.currentPreviewItemIndex = indexPath.row
            
            // Pousser le QLPreviewController
            self.navigationController?.pushViewController(previewController, animated: true)
        }

}
