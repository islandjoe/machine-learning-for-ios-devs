import UIKit
import Vision

class DogCatDetector {
  
  static func beginDetection(_ imageView: UIImageView,
                             completion: @escaping
    (_ classifications: [String])-> Void) {
    
    let image = imageView.image!
    let value = UInt32(image.imageOrientation.rawValue)
    let imgOrientation = CGImagePropertyOrientation(rawValue: value)!
    let requestHandler = VNImageRequestHandler(
          cgImage: image.cgImage!,
             orientation: imgOrientation,
                options: [:])
    
    guard let model = try? VNCoreMLModel(for: CatDogClassifier().model) else {
      print("Couldn't load model"); return
    }
    
    let detectionRequest = VNCoreMLRequest(model: model) {
      (request, error) in
      
      guard let observations = request.results else {
        print("No results"); return
      }
      
      let classifications = observations
        .compactMap { $0 as? VNClassificationObservation }
          .filter { $0.confidence > 0.9 }
            .map { $0.identifier }
      
      completion( classifications )
    }
    
    do {
      try requestHandler.perform( [detectionRequest] )
    } catch {
      print(error.localizedDescription)
    }
  }
}

extension CGImagePropertyOrientation {
  init(_ orientation: UIImageOrientation) {
    switch orientation {
    case .up:            self = .up
    case .upMirrored:    self = .upMirrored
    case .down:          self = .down
    case .downMirrored:  self = .downMirrored
    case .left:          self = .left
    case .leftMirrored:  self = .leftMirrored
    case .right:         self = .right
    case .rightMirrored: self = .rightMirrored
    }
  }
}
