extension UITextField{
    
    func bottomBorder()
    {
        let bottomBorder = CALayer()
        
        bottomBorder.frame = CGRect(x: 0, y: self.frame.size.height - 1, width: self.frame.size.width, height: 30)
        bottomBorder.backgroundColor = UIColor.black.cgColor
        
        self.layer.addSublayer(bottomBorder)
    }
    
    func borderWhite()
    {
        let bottomBorder = CALayer()
        
         bottomBorder.frame = CGRect(x: 0, y: self.frame.size.height - 1, width: self.frame.size.width, height: 30)
        bottomBorder.backgroundColor = UIColor.white.cgColor
        
        self.layer.addSublayer(bottomBorder)
    } 
}

extension String
{
    var containsUnicodeCharacters: Bool
    {
        for scalar in unicodeScalars
        {
            if scalar.value > 0xF00
            {
                return true
            }
        }
        return false
    }
}

//UIImageView
extension UIImageView
{
    func roundedImage()
    {
        let maskPAth1 = UIBezierPath(roundedRect: self.bounds,
                                     byRoundingCorners: [.topLeft , .topRight],
                                     cornerRadii:CGSize(width: 8.0, height: 8.0))
        let maskLayer1 = CAShapeLayer()
        maskLayer1.frame = self.bounds
        maskLayer1.path = maskPAth1.cgPath
        self.layer.mask = maskLayer1
        
    }
    
    func imageLayerDesign()
    {
        self.layer.masksToBounds = true
        self.layer.borderWidth = 3
        self.layer.borderColor = UIColor.lightGray.cgColor
        self.layer.cornerRadius = self.frame.size.width / 2
        self.layer.shadowColor = UIColor.black.cgColor
        self.layer.shadowOpacity = 20
        self.layer.shadowOffset = CGSize(width: 0, height: 1)
        self.layer.shadowRadius = self.bounds.width / 2
    }
}

//UIView
extension UIView
{
    func roundedView()
    {
        let maskPAth1 = UIBezierPath(roundedRect: self.bounds,
                                     byRoundingCorners: [.topLeft , .topRight],
                                     cornerRadii:CGSize(width: 8.0, height: 8.0))
        let maskLayer1 = CAShapeLayer()
        maskLayer1.frame = self.bounds
        maskLayer1.path = maskPAth1.cgPath
        
        self.layer.mask = maskLayer1
    }
    
    func radShadowView()
    {
        self.layer.cornerRadius = 4
        self.layer.shadowColor = UIColor.gray.cgColor
        self.layer.shadowOffset = CGSize.zero
        self.layer.shadowOpacity = 0.7
        self.layer.shadowRadius = 2
    }
}

//UICollectionViewCell
extension UICollectionViewCell
{
    func shadowOfCell()
    {
        self.layer.cornerRadius = 4
        self.layer.shadowColor = UIColor.darkGray.cgColor
        self.layer.shadowOffset = CGSize(width: 0, height: 1)
        self.layer.shadowOpacity = 20
        self.layer.shadowRadius = 2
        self.clipsToBounds = false
        self.layer.masksToBounds = false
    }
}

//UICOLOR Hexa

extension UIColor
{
    convenience init(red: Int, green: Int, blue: Int, a: CGFloat = 1.0)
    {
        self.init(
            red: CGFloat(red) / 255.0,
            green: CGFloat(green) / 255.0,
            blue: CGFloat(blue) / 255.0,
            alpha: a)
    }
    
    convenience init(rgb: Int, a: CGFloat = 1.0)
    {
        self.init(
            red: (rgb >> 16) & 0xFF,
            green: (rgb >> 8) & 0xFF,
            blue: rgb & 0xFF,
            a: a)
    }
}

 //MARK:- Color - UICOLOR Extension
    open static func DarkPrimaryColor() -> UIColor
    {
        return UIColor(rgb: 0xD59E00, a: 1)
    }
    open static func PrimaryColor() -> UIColor
    {
        return UIColor(rgb: 0xF1BA1B, a: 1)
    }
    open static func DividerColor() -> UIColor
    {
        return UIColor(rgb: 0xE5E5E5, a: 1)
    }
    open static func BackgroundColor() -> UIColor
    {
        return UIColor(rgb: 0xF5F5F5, a: 1)
    }
    open static func themeColor() -> UIColor
    {
        return UIColor(rgb: 0x0488d1, a: 1)
    }
	

// MARK: - OpalImagePickerControllerDelegate
var arrImageOrVideo = [Any]()

extension ViewController: OpalImagePickerControllerDelegate {
    func imagePicker(_ picker: OpalImagePickerController, didFinishPickingAssets assets: [PHAsset]) {
        dismiss(animated: true, completion: nil)
        for asset in assets {
            // Add PHAsset
            if asset.mediaType == .image {
                arrImageOrVideo.append(asset)
            }
        }
	    
	assetToData()
    }

func assetToData() {
        var imagesData = [Data]()
        let dispatchGroup = DispatchGroup()
        //showLoader()
        for item in arrImageOrVideo {
            // Enter in disptach
            dispatchGroup.enter()
            
            if let phAsset = item as? PHAsset {
                // get data
                if phAsset.mediaType == .image {        // It's image
                    phAsset.requestContentEditingInput(with: PHContentEditingInputRequestOptions(), completionHandler: { (contentEditingInput, _) in
                        if let imageURL = contentEditingInput?.fullSizeImageURL {
                            do {
                                let data = try Data(contentsOf: imageURL)
                                imagesData.append(data)
                            } catch let error {
                                print(error.localizedDescription)
                            }
                        }
                        
                        dispatchGroup.leave()
                        
                    })
                } else {
                    dispatchGroup.leave()
                }
            } else {
                dispatchGroup.leave()
            }
        }
        
        dispatchGroup.notify(queue: .main) {
            // Upload your data to the server
            
        }
    }
	
  func cellForRow(index: Int) {
        if arrImageOrVideo.count > 0 {
            let width = (UIScreen.main.bounds.width - 15) / 3
            let asset = arrImageOrVideo[index] as? PHAsset
            
            if asset?.mediaType == .image {
                PHImageManager.default().requestImage(for: asset!, targetSize: CGSize(width: width, height: width), contentMode: PHImageContentMode.aspectFit, options: nil) { (image, userInfo) -> Void in
                    
                    cell.imgProduct.image = image
                    cell.imgPlay.isHidden = asset!.mediaType == PHAssetMediaType.image ? true : false
                }
            } else {
                if let strUrl = arrImageOrVideo[indexPath.row] as? String {
                    cell.imgProduct.sd_setImage(with: URL(string: strUrl), placeholderImage: placeholderImage, options: .refreshCached)
                }
            }
        }
    }
	
	
//Delete Image from array
    var imageName = ""
    @objc func deleteImageAndVideo(_ sender: UIButton) {
        if self.arrImageOrVideo.count > sender.tag {
            self.getNameFromArray(index: sender.tag) { (name) in
                self.imageName = name
            }
        }
    }
    
   private func getNameFromArray(index: Int, completion: @escaping (_ name: String) -> Void) {
       let asset = arrImageOrVideo[index] as? PHAsset
       
       if asset?.mediaType == .image {
           asset!.requestContentEditingInput(with: PHContentEditingInputRequestOptions(), completionHandler: { (contentEditingInput, _) in
               if let strURL = (contentEditingInput!.audiovisualAsset as? AVURLAsset)?.url.absoluteString {
                   let strName: String = self.getStringSplitArray(str: strURL, separator: "/")
                   completion(strName)
               }
           })
       } else {
           if let strURL = arrImageOrVideo[index] as? String {
               let strName: String = self.getStringSplitArray(str: strURL, separator: "/")
               completion(strName)
           }
       }
   }
   
   func getStringSplitArray(str: String, separator: Character) -> String {
       let arr = str.split(separator: separator)
       let strName: String = String(arr[arr.count - 1])
       
       return strName
   }
}
