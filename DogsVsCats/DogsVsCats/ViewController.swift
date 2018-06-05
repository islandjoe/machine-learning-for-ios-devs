import UIKit

class ViewController: UIViewController {

  @IBOutlet weak var checkAnimalButton: UIButton!
  @IBOutlet weak var imageView: UIImageView!
  @IBOutlet weak var classificationLabel: UILabel!
  
  override func viewDidLoad() {
    super.viewDidLoad()
  }
  
  @IBAction func selectImageSource(_ sender: Any) {
    let imagePicker      = UIImagePickerController()
    imagePicker.delegate = self
    
    let imgSrcActions = UIAlertController(title: "Image Source",
                                        message: "Choose an image to continue.",
                                      preferredStyle: .actionSheet)
    
    let alert = UIAlertAction(title: "Photo Library", style: .default) {
      (action: UIAlertAction) in
      
      imagePicker.sourceType = .photoLibrary
      self.present(imagePicker, animated: true)
    }
    let cancel = UIAlertAction(title: "Cancel", style: .cancel)
    
    imgSrcActions.addAction( alert )
    imgSrcActions.addAction( cancel )
    self.present(imgSrcActions, animated: true)
  }
  
  @IBAction func checkAnimal(_ sender: Any) {
    DogCatDetector.beginDetection(imageView) {
      (results) in
      
      guard let awww = results.first else {
        print("Could not detect"); return
      }
      
      DispatchQueue.main.async {
        self.classificationLabel.text = "It's a \(awww)"
      }
    }
  }
  
  override func didReceiveMemoryWarning() {
    super.didReceiveMemoryWarning()
    // Dispose of any resources that can be recreated.
  }

}

extension ViewController: UIImagePickerControllerDelegate, UINavigationControllerDelegate {
  
  func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : Any]) {
    
    guard let selectedImg = info[UIImagePickerControllerOriginalImage] as? UIImage
    else {
      picker.dismiss(animated: true)
      print("Couldn't select image")
      
      return
    }
    
    imageView.image = selectedImg
    imageView.contentMode = .scaleAspectFill
    checkAnimalButton.isEnabled = true
    
    picker.dismiss(animated: true)
  }
  
  func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
    picker.dismiss(animated: true)
  }
  
}
