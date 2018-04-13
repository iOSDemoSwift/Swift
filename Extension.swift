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
	
	
