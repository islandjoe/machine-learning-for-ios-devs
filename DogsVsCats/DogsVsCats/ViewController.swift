import UIKit

class ViewController: UIViewController {

  @IBOutlet weak var checkAnimalButton: UIButton!
  @IBOutlet weak var imageView: UIImageView!
  @IBOutlet weak var classificationLabel: UILabel!
  
  override func viewDidLoad() {
    super.viewDidLoad()
  }
  
  @IBAction func selectImageSource(_ sender: Any) {
    
    let imagePicker = UIImagePickerController()
    imagePicker.delegate = self
  }
  
  @IBAction func checkAnimal(_ sender: Any) {
    
  }
  
  override func didReceiveMemoryWarning() {
    super.didReceiveMemoryWarning()
    // Dispose of any resources that can be recreated.
  }

}

extension ViewController: UIImagePickerControllerDelegate, UINavigationControllerDelegate {
  
  func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : Any]) {
    
  }
  
  func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
    picker.dismiss(animated: true)
  }
  
}
