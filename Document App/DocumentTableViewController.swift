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

extension DocumentTableViewController: UIDocumentPickerDelegate {
    
    func documentPicker(_ controller: UIDocumentPickerViewController, didPickDocumentsAt urls: [URL]) {
        guard let selectedFileURL = urls.first else { return }
        
        guard selectedFileURL.startAccessingSecurityScopedResource() else {
            return
        }

        defer {
            selectedFileURL.stopAccessingSecurityScopedResource()
        }
        
        let resourcesValues = try! selectedFileURL.resourceValues(forKeys: [.contentTypeKey, .nameKey, .fileSizeKey])
        
        let newDoc = DocumentFile(title: selectedFileURL.lastPathComponent, size: resourcesValues.fileSize ?? 0, imageName: nil, url: selectedFileURL, type: resourcesValues.contentType!.description)
        
        
        DocumentTableViewController.documentsFiles.append(newDoc)
        self.copyFileToDocumentsDirectory(fromUrl: selectedFileURL)
        tableView.reloadData()
    }
    
    func copyFileToDocumentsDirectory(fromUrl url: URL) {
            // On récupère le dossier de l'application, dossier où nous avons le droit d'écrire nos fichiers
            let documentsDirectory = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first!
            
            // Nous créons une URL de destination pour le fichier
            let destinationUrl = documentsDirectory.appendingPathComponent(url.lastPathComponent)
            
            do {
                // Puis nous copions le fichier depuis l'URL source vers l'URL de destination
                try FileManager.default.copyItem(at: url, to: destinationUrl)
            } catch {
                print(error)
            }
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
        let documentPicker = UIDocumentPickerViewController(forOpeningContentTypes: [.item])
        documentPicker.delegate = self
        documentPicker.modalPresentationStyle = .overFullScreen

        present(documentPicker, animated: true)

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
