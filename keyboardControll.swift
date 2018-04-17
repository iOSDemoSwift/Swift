//TPKeyboardAvoidingScrollView, BSKeyboardControls

class viewcontroller: Viewcontroller, BSKeyboardControlsDelegate, UIScrollViewDelegate
{
	@IBOutlet var MainScrollView: TPKeyboardAvoidingScrollView!
    @IBOutlet var keyboardControls: BSKeyboardControls!
	
	var activField: UITextField?
	
	 override func viewDidLoad()
    {
        super.viewDidLoad()
        
        let fields: [AnyObject] = [txtFullName, txtEmail, txtPassword]
        self.keyboardControls = BSKeyboardControls(fields: fields)
        self.keyboardControls.delegate = self
        
        self.MainScrollView = TPKeyboardAvoidingScrollView()
        
        self.MainScrollView.contentSizeToFit()
		}
		
		
    
    //Keyboard
    // Function Keybord Control
    
    func dismissKeyboard()
    {
        view.endEditing(true)
    }
    
    func keyboardControlsDonePressed(_ keyboardControls: BSKeyboardControls)
    {
        self.dismissKeyboard()
    }
    
    func textFieldShouldBeginEditing(_ textField: UITextField) -> Bool
    {
        return true
    }
	
	func textFieldDidBeginEditing(_ textField: UITextField) 
		{
			//self.activField = textField
			self.keyboardControls!.activeField = textField
		}
		
		 func textFieldShouldEndEditing(_ textField: UITextField) -> Bool
    {
        return true
    }

}
