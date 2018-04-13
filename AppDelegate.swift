//For Social Login with Firebase and Paypal
import UIKit        //Framwork for app user interface
import Firebase     //configure with firebase app
import FirebaseAuth //Firebase Authentication
import GoogleSignIn //For Google
import FBSDKCoreKit //For Facebook

@UIApplicationMain //marker 
class AppDelegate: UIResponder, UIApplicationDelegate, GIDSignInDelegate
{

    var window: UIWindow?


    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplicationLaunchOptionsKey: Any]?) -> Bool {
        //configure with firebase app
        FirebaseApp.configure()
        
         UIApplication.shared.statusBarStyle = .lightContent
         UIApplication.shared.statusBarView?.backgroundColor = DarkPrimaryColor()
        
        //For Google signin
        GIDSignIn.sharedInstance().clientID = FirebaseApp.app()?.options.clientID
        GIDSignIn.sharedInstance().delegate = self
        
        //Facebook Sign in
        FBSDKApplicationDelegate.sharedInstance().application(application, didFinishLaunchingWithOptions: launchOptions)
        
        //For Paypal
       PayPalMobile.initializeWithClientIds(forEnvironments: [PayPalEnvironmentProduction: "facilitator@gmail.com", PayPalEnvironmentSandbox: "Key"])
        
        return true
    }
    
    func application(_ app: UIApplication, open url: URL, options: [UIApplicationOpenURLOptionsKey : Any] = [:]) -> Bool {
        //Facebook
        let handle = FBSDKApplicationDelegate.sharedInstance().application(app, open: url, sourceApplication: options[UIApplicationOpenURLOptionsKey.sourceApplication] as! String!, annotation: options[UIApplicationOpenURLOptionsKey.annotation])
        //For Google
        GIDSignIn.sharedInstance().handle(url,sourceApplication: options[UIApplicationOpenURLOptionsKey.sourceApplication] as! String!, annotation: options[UIApplicationOpenURLOptionsKey.annotation])
        
        return handle
    }
    
    //For Google
    func sign(_ signIn: GIDSignIn!, didSignInFor user: GIDGoogleUser!, withError error: Error?) {
        if let error = error {
            print(error.localizedDescription)
            return
        }
        
        guard let idToken = user.authentication.idToken else { return }
        
        guard let accessToken = user.authentication.accessToken else { return }
        
        let credential = GoogleAuthProvider.credential(withIDToken: idToken, accessToken: accessToken)
        
        Auth.auth().signIn(with: credential) { (user, error) in
            
            if let err = error
            {
                print("Failed to Google Login ", err)
                return
            }
            
            guard let uid = user?.uid else { return }
            
            print("sucessfull Login ", uid)
            
        }
    }
    }
