https://medium.com/swift-programming/nifty-and-swifty-resources-for-ios-and-swift-developers-33e1e39084e4
8460127127

ADMob Test ID
————————
Banner				-	ca-app-pub-3940256099942544/2934735716
Interstitial			-	ca-app-pub-3940256099942544/4411468910
Interstitial Video		-	ca-app-pub-3940256099942544/5135589807
Rewarded Video		-	ca-app-pub-3940256099942544/1712485313
Native Advanced		-	ca-app-pub-3940256099942544/3986624511
Native Advanced Video	-	ca-app-pub-3940256099942544/2521693316
========================================================================
———————————————————————————————————————————————

Fb - significantinfotech@gmail.com
ws@@2015

Make .PEM File
----------------
cd
cd Desktop
openssl pkcs12 -in nameofp12.p12 -out abc.pem -nodes -clcerts

https://www.cnblogs.com/wanpengcoder/p/5281416.html

========================================================================
———————————————————————————————————————————————
Get UUID from dSYM
———————————
.dSYM file location in Terminal
$> mdls -name com_apple_xcode_dsym_uuids -raw "$APP_NAME.app.dSYM" | grep -e \" | sed 's/[ |\"]//g'

========================================================================
———————————————————————————————————————————————

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
———————————————————————————————
extension UIColor {
    public convenience init?(hexString: String) {
        let r, g, b, a: CGFloat

        if hexString.hasPrefix("#") {
            let start = hexString.index(hexString.startIndex, offsetBy: 1)
            let hexColor = String(hexString[start...])

            if hexColor.count == 8 {
                let scanner = Scanner(string: hexColor)
                var hexNumber: UInt64 = 0

                if scanner.scanHexInt64(&hexNumber) {
                    r = CGFloat((hexNumber & 0xff000000) >> 24) / 255
                    g = CGFloat((hexNumber & 0x00ff0000) >> 16) / 255
                    b = CGFloat((hexNumber & 0x0000ff00) >> 8) / 255
                    a = CGFloat(hexNumber & 0x000000ff) / 255

                    self.init(red: r, green: g, blue: b, alpha: a)
                    return
                }
            }
        }

        return nil
    }
}
//Use
let color = UIColor(hexString: "#3f3f3f")

==========================================================================
———————————————————————————————————————————————
Animation
—————
Bottom -> Top
———————
let transition = CATransition()
transition.duration = 0.5
transition.timingFunction = CAMediaTimingFunction(name: kCAMediaTimingFunctionEaseOut)
transition.type = kCATransitionMoveIn
transition.subtype = kCATransitionFromTop
self.navigationController?.view.layer.add(transition, forKey: nil)
self.navigationController?.pushViewController(view controller, animated: false)

Top -> Bottom
———————
let transition = CATransition()
transition.duration = 0.5
transition.timingFunction = CAMediaTimingFunction(name: kCAMediaTimingFunctionEaseOut)
transition.type = kCATransitionReveal
transition.subtype = kCATransitionFromBottom            
self.navigationController?.view.layer.add(transition, forKey: nil)
self.navigationController?.popViewController(animated: false)

Back Effect
------------
let transition = CATransition()
transition.duration = 0.5
transition.timingFunction = CAMediaTimingFunction(name: kCAMediaTimingFunctionEaseOut)
transition.type = kCATransitionPush
transition.subtype = kCATransitionFromLeft
self.navigationController?.view.layer.add(transition, forKey: nil)
self.navigationController?.popViewController(animated: false)

==============================++++++++=======================================
Ads
——-
import GoogleMobileAds

GADInterstitialDelegate, GADBannerViewDelegate

var bannerView: GADBannerView!
var interstitial: GADInterstitial?

interstitial = createAndLoadInterstitial()        
self.bannerAds()

//Banner and Intertial Ad
    private func createAndLoadInterstitial() -> GADInterstitial?
    {
        interstitial = GADInterstitial(adUnitID: Constants.Interstitial_Unit_Id)
        guard let interstitial = interstitial else {
            return nil
        }
        let request = GADRequest()
        interstitial.load(request)
        interstitial.delegate = self
        return interstitial
    }
    
    func interstitialDidReceiveAd(_ ad: GADInterstitial)
    {
        print("Receibed ad.")
        ad.present(fromRootViewController: self)
    }

    func interstitialDidDismissScreen(_ ad: GADInterstitial)
    {
	//
    }

    func interstitial(_ ad: GADInterstitial, didFailToReceiveAdWithError error: GADRequestError)
    {
       	print(error)
    }    

    func bannerAds()
    {
        // In this case, we instantiate the banner with desired ad size.
        bannerView = GADBannerView(adSize: kGADAdSizeBanner)
        bannerView.adUnitID = Constants.Banner_Unit_Id
        bannerView.delegate = self
        bannerView.rootViewController = self
        bannerView.load(GADRequest())
        addBannerViewToView(bannerView)
    }
    
    func addBannerViewToView(_ bannerView: GADBannerView)
    {
        bannerView.translatesAutoresizingMaskIntoConstraints = true
        bannerView.frame = CGRect(x: 0.0, y: 0.0, width: adView.frame.width, height: 50)
        adView.addSubview(bannerView)
    }
    
    func adViewDidReceiveAd(_ bannerView: GADBannerView)
    {
        // Add banner to view and add constraints as above.
        addBannerViewToView(bannerView)
    }
=================================================================================
pod 'ReachabilitySwift'
Import Reachability  
NotificationCenter.default.addObserver(self, selector: #selector(self.reachabilityChanged),name: Notification.Name.reachabilityChanged,object: reachability)
do
{
 	try reachability.startNotifier()
 }
catch
{
          print("could not start reachability notifier")
 }

//method
 @objc func reachabilityChanged(note: Notification) 
 {      
        let reachability = note.object as! Reachability        
        if reachability.isReachable 
	{
         	if reachability.isReachableViaWiFi 
		{
                	 	print("Reachable via WiFi")
            	} else {
                		print("Reachable via Cellular")
            	}
        } else {
         	print("Network not reachable")
        }
    }
=========================================================================
extension UIViewController {
    //to show toast message
    func showToast(message : String) {
        let toastLabel = UILabel(frame: CGRect(x: self.view.frame.size.width/2 - ((self.view.frame.size.width - 20)/2), y: self.view.frame.size.height-100, width: self.view.frame.size.width - 20, height: 35))
        toastLabel.backgroundColor = UIColor.black.withAlphaComponent(0.6)
        toastLabel.textColor = UIColor.white
        toastLabel.textAlignment = .center;
        toastLabel.font = UIFont(name: "Gotham-Book", size: 12.0)
        toastLabel.text = message
        toastLabel.alpha = 1.0
        toastLabel.layer.cornerRadius = 10;
        toastLabel.clipsToBounds  =  true
        self.view.addSubview(toastLabel)
        UIView.animate(withDuration: 4.0, delay: 2.0, options: .curveEaseOut, animations: {
            toastLabel.alpha = 0.0
        }, completion: {(isCompleted) in
            toastLabel.removeFromSuperview()
        })
    }
}
=========================================================================
SET FONT AND COLOR NAVIGATIONBAR TITILE
————————————————————————
let attr = [
            NSAttributedStringKey.foregroundColor: UIColor.white,
            NSAttributedStringKey.font: UIFont(name: "Andada", size: 18)! ]
        
        UINavigationBar.appearance().titleTextAttributes = attr

let textAttribute = [NSAttributedStringKey.foregroundColor: UIColor.white]
        self.navigationController?.navigationBar.titleTextAttributes = textAttribute
=========================================================================
extension UIView {
    func roundCorners(_ corners:UIRectCorner, radius: CGFloat) {
        let path = UIBezierPath(roundedRect: self.bounds, byRoundingCorners: corners, cornerRadii: CGSize(width: radius, height: radius))
        let mask = CAShapeLayer()
        mask.path = path.cgPath
        self.layer.mask = mask
    }
    
    func dropShadow()
    {
        self.layer.cornerRadius = 10
        self.layer.shadowColor = UIColor.black.cgColor
        self.layer.shadowOpacity = 0.5
        self.layer.shadowOffset = CGSize.zero
        self.layer.shadowRadius = 10
    }
    
    func addshadow(top: Bool, left: Bool, bottom: Bool, right: Bool, shadowRadius: CGFloat = 2.0)
    {
        self.layer.cornerRadius = 10
        self.layer.masksToBounds = false
        self.layer.shadowOffset = CGSize(width: 0.0, height: 0.0)
        self.layer.shadowRadius = shadowRadius
        self.layer.shadowOpacity = 0.5
        
        let path = UIBezierPath()
        var x: CGFloat = 0
        var y: CGFloat = 0
        var viewWidth = self.frame.width
        var viewHeight = self.frame.height
        
        // here x, y, viewWidth, and viewHeight can be changed in
        // order to play around with the shadow paths.
        if (!top) {
            y+=(shadowRadius+1)
        }
        if (!bottom) {
            viewHeight-=(shadowRadius+1)
        }
        if (!left) {
            x+=(shadowRadius+1)
        }
        if (!right) {
            viewWidth-=(shadowRadius+1)
        }
        // selecting top most point
        path.move(to: CGPoint(x: x, y: y))
        // Move to the Bottom Left Corner, this will cover left edges
        /*
         |☐
         */
        path.addLine(to: CGPoint(x: x, y: viewHeight))
        // Move to the Bottom Right Corner, this will cover bottom edge
        /*
         ☐
         -
         */
        path.addLine(to: CGPoint(x: viewWidth, y: viewHeight))
        // Move to the Top Right Corner, this will cover right edge
        /*
         ☐|
         */
        path.addLine(to: CGPoint(x: viewWidth, y: y))
        // Move back to the initial point, this will cover the top edge
        /*
         _
         ☐
         */
        path.close()
        self.layer.shadowPath = path.cgPath
    }
}
=========================================================================

Local Notification
————————-
AppDelegate
———————
import UserNotifications

=>didFinishLaunchingWithOptions
{
	UNUserNotificationCenter.current().requestAuthorization(options: [.alert, .badge, .sound]) { (granted, error) in
            print("granted: (\(granted)")
        }
}

import UserNotifications
UNUserNotificationCenterDelegate

private func scheduleLocalNotification()
    {
//        let ok = UNNotificationAction(identifier: "share", title: "Share", options: [])
//        let cancel = UNNotificationAction(identifier: "dismiss", title: "Dismiss", options: [])
//        let category = UNNotificationCategory(identifier: "message", actions: [ok, cancel], intentIdentifiers: ["share", "dismiss"], options: [])
//        UNUserNotificationCenter.current().setNotificationCategories([category])
        
	UNUserNotificationCenter.current().delegate = self
        // Create Notification Content
        let notificationContent = UNMutableNotificationContent()
        var strTitle = String()
        
        // Configure Notification Content
        notificationContent.title = "goStylists!"
        //notificationContent.subtitle = "Local Notifications"
        
        if let str =  UserDefaults.standard.value(forKey: "video")
        {
            strTitle = str as! String
            UserDefaults.standard.removeObject(forKey: "video")
        }
        else if let str =  UserDefaults.standard.value(forKey: "image")
        {
            strTitle = str as! String
            UserDefaults.standard.removeObject(forKey: "image")
        }
        notificationContent.body = strTitle + " Upload Completed"
        
//        notificationContent.categoryIdentifier = "message"
        
        // Add Trigger
        let notificationTrigger = UNTimeIntervalNotificationTrigger(timeInterval: 1.0, repeats: false)
        
        // Create Notification Request
        let notificationRequest = UNNotificationRequest(identifier: "local_notification", content: notificationContent, trigger: notificationTrigger)
        
        // Add Request to User Notification Center
        UNUserNotificationCenter.current().add(notificationRequest) { (error) in
            if let error = error
            {
                print("Unable to Add Notification Request (\(error), \(error.localizedDescription))")
            }
        }
        self.appDelegate.startTimer()
    }
   
    func userNotificationCenter(_ center: UNUserNotificationCenter, willPresent notification: UNNotification, withCompletionHandler completionHandler: @escaping (UNNotificationPresentationOptions) -> Void)
    {
        completionHandler([.alert, .sound])
    }
    
    func userNotificationCenter(_ center: UNUserNotificationCenter, didReceive response: UNNotificationResponse, withCompletionHandler completionHandler: @escaping () -> Void)
    {
        if let url: String = UserDefaults.standard.value(forKey: "ReturnUrl") as? String // Fb Share Link
        {
            _ = SweetAlert().showAlert("Upload Complete", subTitle: "Generate FB Ad URL?", style: AlertStyle.success, buttonTitle:"YES", buttonColor:UIColor.colorFromRGB(0x4B7933), otherButtonTitle: "NOPE", otherButtonColor: UIColor.colorFromRGB(0x4B7933)) { (action) -> Void in
                if action == true
                {
                    
                    if (MFMessageComposeViewController.canSendText())
                    {
                        //UserDefaults.standard.removeObject(forKey: "Foreground")
                        UserDefaults.standard.removeObject(forKey: "ReturnUrl")
                        print(url)
                        let controller = MFMessageComposeViewController()
                        controller.body = url
                        controller.messageComposeDelegate = self
                        UserDefaults.standard.set(true, forKey: "LinkShare")
                        UserDefaults.standard.synchronize()
                        self.present(controller, animated: true, completion: nil)
                    }
                    
                }
                else
                {
                    UserDefaults.standard.removeObject(forKey: "ReturnUrl")
                    self.dismiss(animated: true, completion: nil)
                }
                
            }
        }
    }
====================================================================
CollectionviewcellShadow
——————————————————————————————
cell.contentView.layer.cornerRadius = 4.0
        cell.contentView.layer.borderWidth = 1.0
        cell.contentView.layer.borderColor = UIColor.clear.cgColor
        cell.contentView.layer.masksToBounds = true
        cell.layer.shadowColor = UIColor.lightGray.cgColor
        cell.layer.shadowOffset = CGSize(width:0,height: 2.0)
        cell.layer.shadowRadius = 4.0
        cell.layer.shadowOpacity = 1.0
        cell.layer.masksToBounds = false;
        cell.layer.shadowPath = UIBezierPath(roundedRect:cell.bounds, cornerRadius:cell.contentView.layer.cornerRadius).cgPath
====================================================================
Inernetconnection
+++++++++++++
Reachability.swift
—————————
import SystemConfiguration

public class Reachability
{
    class func isConnectedToNetwork() -> Bool
    {
        var zeroAddress = sockaddr_in(sin_len: 0, sin_family: 0, sin_port: 0, sin_addr: in_addr(s_addr: 0), sin_zero: (0, 0, 0, 0, 0, 0, 0, 0))
        zeroAddress.sin_len = UInt8(MemoryLayout.size(ofValue: zeroAddress))
        zeroAddress.sin_family = sa_family_t(AF_INET)
        
        let defaultRouteReachability = withUnsafePointer(to: &zeroAddress)
        {
            $0.withMemoryRebound(to: sockaddr.self, capacity: 1) {zeroSockAddress in
                SCNetworkReachabilityCreateWithAddress(nil, zeroSockAddress)
            }
        }
        
        var flags: SCNetworkReachabilityFlags = SCNetworkReachabilityFlags(rawValue: 0)
        if SCNetworkReachabilityGetFlags(defaultRouteReachability!, &flags) == false
        {
            return false
        }
        
        let isReachable = flags == .reachable
        let needsConnection = flags == .connectionRequired
        
        return isReachable && !needsConnection
    }
}

protocol Utilities {
}

extension NSObject:Utilities{
    
    
    enum ReachabilityStatus {
        case notReachable
        case reachableViaWWAN
        case reachableViaWiFi
    }
    
    var currentReachabilityStatus: ReachabilityStatus {
        
        var zeroAddress = sockaddr_in()
        zeroAddress.sin_len = UInt8(MemoryLayout<sockaddr_in>.size)
        zeroAddress.sin_family = sa_family_t(AF_INET)
        
        guard let defaultRouteReachability = withUnsafePointer(to: &zeroAddress, {
            $0.withMemoryRebound(to: sockaddr.self, capacity: 1) {
                SCNetworkReachabilityCreateWithAddress(nil, $0)
            }
        }) else {
            return .notReachable
        }
        
        var flags: SCNetworkReachabilityFlags = []
        if !SCNetworkReachabilityGetFlags(defaultRouteReachability, &flags) {
            return .notReachable
        }
        
        if flags.contains(.reachable) == false {
            // The target host is not reachable.
            return .notReachable
        }
        else if flags.contains(.isWWAN) == true {
            // WWAN connections are OK if the calling application is using the CFNetwork APIs.
            return .reachableViaWWAN
        }
        else if flags.contains(.connectionRequired) == false {
            // If the target host is reachable and no connection is required then we'll assume that you're on Wi-Fi...
            return .reachableViaWiFi
        }
        else if (flags.contains(.connectionOnDemand) == true || flags.contains(.connectionOnTraffic) == true) && flags.contains(.interventionRequired) == false {
            // The connection is on-demand (or on-traffic) if the calling application is using the CFSocketStream or higher APIs and no [user] intervention is needed
            return .reachableViaWiFi
        }
        else {
            return .notReachable
        }
    }
    
}

Call
——-
if Reachability.isConnectedToNetwork() == true
        {
            print("Internet connection OK")
        }
        else
        {
            print("Internet connection FAILED")
            let alert = UIAlertView(title: "No Internet Connection", message: "Make sure your device is connected to the internet.", delegate: nil, cancelButtonTitle: "OK")
            alert.show()
        }

Call
——
if currentReachabilityStatus != .notReachable { }

-====================
Background Timer
——————————
var timer: Timer?
var counterTask: UIBackgroundTaskIdentifier = 0

viewDidLoad()
{
	counterTask = UIApplication.shared.beginBackgroundTask(expirationHandler: {() -> Void in
            // If you're worried about exceeding 10 minutes, handle it here
        })
        self.startTimer()
}

 func startTimer()
    {
        if timer == nil
        {
            timer =  Timer.scheduledTimer(timeInterval: TimeInterval(20),  target : self, selector : #selector(self.reachabilityChanged), userInfo : nil, repeats : true) }        
    }
    
    func stopTimer()
    {
        if timer != nil
        {
            timer?.invalidate()
            timer = nil
        }
    }

   @objc open func reachabilityChanged() //note: Notification
    {
       // let objEvent = EvidenceLocationViewController()
        
        if Reachability.isConnectedToNetwork() == true
        {
            stopTimer()
           // objEvent.uploadInternetAvailable()
        }
        else
        {
            print("Network not reachable")
        }
    }	
====================================================================
Swipe Controller Navigation
———————————————
——————————
, UIGestureRecognizerDelegate

 self.navigationController?.interactivePopGestureRecognizer?.delegate = self
 self.navigationController?.interactivePopGestureRecognizer?.isEnabled = true
====================================================================

ScreenShot
——————

func takeScreenshot(view: UIView) -> UIImage //UIImageView
    {
        UIGraphicsBeginImageContextWithOptions(view.bounds.size, false, 0)
        let context: CGContext = UIGraphicsGetCurrentContext()!
        view.layer.render(in: context)
        let image = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        return image!
    }

====================================================================
Slow Motion
——————
- (void)SlowMotion:(NSURL *)URl
{
    AVURLAsset* videoAsset = [AVURLAsset URLAssetWithURL:URl options:nil]; //self.inputAsset;
    
    AVAsset *currentAsset = [AVAsset assetWithURL:URl];
    NSLog(@"%d",[[currentAsset tracksWithMediaType:AVMediaTypeVideo] count]);
    AVAssetTrack *vdoTrack = [[currentAsset tracksWithMediaType:AVMediaTypeVideo] objectAtIndex:0];
    
    //create mutable composition
    AVMutableComposition *mixComposition = [AVMutableComposition composition];
    
    AVMutableCompositionTrack *compositionVideoTrack = [mixComposition addMutableTrackWithMediaType:AVMediaTypeVideo  	preferredTrackID:kCMPersistentTrackID_Invalid];
    AVMutableCompositionTrack *compositionAudioTrack = [mixComposition addMutableTrackWithMediaType:AVMediaTypeAudio preferredTrackID:kCMPersistentTrackID_Invalid];
    
    NSError *videoInsertError = nil;
    BOOL videoInsertResult = [compositionVideoTrack insertTimeRange:CMTimeRangeMake(kCMTimeZero, videoAsset.duration)
                                                            ofTrack:[[videoAsset tracksWithMediaType:AVMediaTypeVideo] objectAtIndex:0]
                                                             atTime:kCMTimeZero
                                                              error:&videoInsertError];
    if (!videoInsertResult || nil != videoInsertError) {
        //handle error
        return;
    }
    
    NSError *audioInsertError =nil;
    BOOL audioInsertResult =[compositionAudioTrack insertTimeRange:CMTimeRangeMake(kCMTimeZero, videoAsset.duration)
                                                           ofTrack:[[currentAsset tracksWithMediaType:AVMediaTypeAudio] objectAtIndex:0]
                                                            atTime:kCMTimeZero
                                                             error:&audioInsertError];
    
    if (!audioInsertResult || nil != audioInsertError) {
        //handle error
        return;
    }
    
    CMTime duration =kCMTimeZero;
    duration=CMTimeAdd(duration, currentAsset.duration);
    //slow down whole video by 2.0
    double videoScaleFactor = 6.0;
    CMTime videoDuration = videoAsset.duration;
    
    [compositionVideoTrack scaleTimeRange:CMTimeRangeMake(kCMTimeZero, videoDuration)
                               toDuration:CMTimeMake(videoDuration.value*videoScaleFactor, videoDuration.timescale)];
    [compositionAudioTrack scaleTimeRange:CMTimeRangeMake(kCMTimeZero, videoDuration)
                               toDuration:CMTimeMake(videoDuration.value*videoScaleFactor, videoDuration.timescale)];
    [compositionVideoTrack setPreferredTransform:vdoTrack.preferredTransform];
    
    NSArray *dirPaths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSString *docsDir = [dirPaths objectAtIndex:0];
    NSString *outputFilePath = [docsDir stringByAppendingPathComponent:[NSString stringWithFormat:@"slowMotion.mov"]];
    if ([[NSFileManager defaultManager] fileExistsAtPath:outputFilePath])
        [[NSFileManager defaultManager] removeItemAtPath:outputFilePath error:nil];
    NSURL *_filePath = [NSURL fileURLWithPath:outputFilePath];
    
    //export
    AVAssetExportSession* assetExport = [[AVAssetExportSession alloc] initWithAsset:mixComposition
                                                                         presetName:AVAssetExportPresetLowQuality];
    assetExport.outputURL=_filePath;
    assetExport.outputFileType =           AVFileTypeQuickTimeMovie;
    assetExport.shouldOptimizeForNetworkUse = YES;
    [assetExport exportAsynchronouslyWithCompletionHandler:^
     {
         
         switch ([assetExport status]) {
             case AVAssetExportSessionStatusFailed:
             {
                 NSLog(@"Export session faiied with error: %@", [assetExport error]);
                 dispatch_async(dispatch_get_main_queue(), ^{
                     // completion(nil);
                 });
             }
                 break;
             case AVAssetExportSessionStatusCompleted:
             {
                 
                 NSLog(@"Successful");
                 NSURL *outputURL = assetExport.outputURL;
                 
                 ALAssetsLibrary *library = [[ALAssetsLibrary alloc] init];
                 if ([library videoAtPathIsCompatibleWithSavedPhotosAlbum:outputURL]) {
                     
                     [self writeExportedVideoToAssetsLibrary:outputURL];
                 }
                 dispatch_async(dispatch_get_main_queue(), ^{
                     //                                            completion(_filePath);
                 });
                 
             }
                 break;
             default:
                 
                 break;
         }
     }];
}

- (void)writeExportedVideoToAssetsLibrary :(NSURL *)url {
    NSURL *exportURL = url;
    ALAssetsLibrary *library = [[ALAssetsLibrary alloc] init];
    if ([library videoAtPathIsCompatibleWithSavedPhotosAlbum:exportURL]) {
        [library writeVideoAtPathToSavedPhotosAlbum:exportURL completionBlock:^(NSURL *assetURL, NSError *error){
            dispatch_async(dispatch_get_main_queue(), ^{
                if (error) {
                    UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:[error localizedDescription]
                                                                        message:[error localizedRecoverySuggestion]
                                                                       delegate:nil
                                                              cancelButtonTitle:@"OK"
                                                              otherButtonTitles:nil];
                    [alertView show];
                }
                if(!error)
                {
                    // [activityView setHidden:YES];
                    UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"Sucess"
                                                                        message:@"video added to gallery successfully"
                                                                       delegate:nil
                                                              cancelButtonTitle:@"OK"
                                                              otherButtonTitles:nil];
                    [alertView show];
                }
#if !TARGET_IPHONE_SIMULATOR
                [[NSFileManager defaultManager] removeItemAtURL:exportURL error:nil];
#endif
            });
        }];
    } else {
        NSLog(@"Video could not be exported to assets library.");
    }    
}
=========================================================================
extension UIImageView {
    //To set image view in round
    func setRounded() {
        let radius = (self.frame.width / 2) 
        self.layer.cornerRadius = radius
        self.layer.masksToBounds = true
    }
}
=========================================================================
extension Double {
    /// Rounds the double to decimal places value
    func rounded(toPlaces places:Int) -> Double {
        let divisor = pow(10.0, Double(places))
        return (self * divisor).rounded() / divisor
    }
}
=========================================================================
extension Date {
    func dayOfWeek() -> String? {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "EEEE"
        return dateFormatter.string(from: self).capitalized
        // or use capitalized(with: locale) if you want
    }
}
=========================================================================
extension UISearchBar {
    func removeBackgroundImageView(){
        if let view:UIView = self.subviews.first {
            for curr in view.subviews {
                guard let searchBarBackgroundClass = NSClassFromString("UISearchBarBackground") else {
                    return
                }
                if curr.isKind(of:searchBarBackgroundClass){
                    if let imageView = curr as? UIImageView{
                        imageView.removeFromSuperview()
                        break
                    }
                }
            }
        }
    }
}
=========================================================================
extension UIViewController {
    //to show toast message
    func showToast(message : String) {
        let toastLabel = UILabel(frame: CGRect(x: self.view.frame.size.width/2 - ((self.view.frame.size.width - 20)/2), y: self.view.frame.size.height-100, width: self.view.frame.size.width - 20, height: 35))
        toastLabel.backgroundColor = UIColor.black.withAlphaComponent(0.6)
        toastLabel.textColor = UIColor.white
        toastLabel.textAlignment = .center;
        toastLabel.font = UIFont(name: "Gotham-Book", size: 12.0)
        toastLabel.text = message
        toastLabel.alpha = 1.0
        toastLabel.layer.cornerRadius = 10;
        toastLabel.clipsToBounds  =  true
        self.view.addSubview(toastLabel)
        UIView.animate(withDuration: 4.0, delay: 2.0, options: .curveEaseOut, animations: {
            toastLabel.alpha = 0.0
        }, completion: {(isCompleted) in
            toastLabel.removeFromSuperview()
        })
    }
}
=========================================================================
extension UITableViewCell {
    
    func hideSeparator() {
        self.separatorInset = UIEdgeInsets(top: 0, left: self.bounds.size.width, bottom: 0, right: 0)
    }
    
    func showSeparator() {
        self.separatorInset = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
    }
}
=========================================================================
extension UIImage {
    func resizeImageWith(newSize: CGSize) -> UIImage {
        
        let horizontalRatio = newSize.width / size.width
        let verticalRatio = newSize.height / size.height
        
        let ratio = max(horizontalRatio, verticalRatio)
        let newSize = CGSize(width: size.width * ratio, height: size.height * ratio)
        UIGraphicsBeginImageContextWithOptions(newSize, true, 0)
        draw(in: CGRect(origin: CGPoint(x: 0, y: 0), size: newSize))
        let newImage = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        return newImage!
    }
    enum JPEGQuality: CGFloat {
        case lowest  = 0
        case low     = 0.25
        case medium  = 0.5
        case high    = 0.75
        case highest = 1
    }
    
    /// Returns the data for the specified image in JPEG format.
    /// If the image object’s underlying image data has been purged, calling this function forces that data to be reloaded into memory.
    /// - returns: A data object containing the JPEG data, or nil if there was a problem generating the data. This function may return nil if the image has no data or if the underlying CGImageRef contains data in an unsupported bitmap format.
    func jpeg(_ quality: JPEGQuality) -> Data? {
        return UIImageJPEGRepresentation(self, quality.rawValue)
    }
}
=========================================================================
extension NSMutableData {
    
    func appendString(string: String) {
        let data = string.data(using: String.Encoding.utf8, allowLossyConversion: true)
        append(data!)
    }
}
=========================================================================
extension FeedbackViewController {
    func hideKeyboardWhenTappedAround() {
        let tap: UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(FeedbackViewController.dismissKeyboard))
        tap.cancelsTouchesInView = false
        view.addGestureRecognizer(tap)
    }
    
    @objc func dismissKeyboard() {
        view.endEditing(true)
    }
}
=========================================================================
class func getDeviceHeight() -> CGFloat
{
        let screenBounds = UIScreen.main.bounds
        return screenBounds.height
  }

let Iphone4sHeight : CGFloat = 480.0
let Iphone_5_Height : CGFloat = 568.0
let Iphone_6_Height : CGFloat = 667.0
let Iphone_6plus_Height : CGFloat = 736.0
let Iphone_X_Height : CGFloat = 812.0
=========================================================================
StatusBar
—————
AppDelegate   ==   UIApplication.shared.statusBarStyle = .lightContent
Info.plist   ==  View controller-based status bar appearance -> No
Into.plist  ==  Status bar style -> UIStatusBarStyleLightContent

Change color NavigationController
—————————————————
if let statusbar = UIApplication.shared.value(forKey: "statusBar") as? UIView
        {
            statusbar.backgroundColor = UIColor(rgb: 0x4EA1D6, a: 0.3)
        }
        UIApplication.shared.statusBarStyle = .lightContent

self.navigationController?.navigationBar.barTintColor = UIColor(red: 50/255, green: 139/255, blue: 204/255)
navigationController?.navigationBar.titleTextAttributes = [NSForegroundColorAttributeName: UIColor.orange]
tabBarController?.tabBar.barTintColor = UIColor.brown
tabBarController?.tabBar.tintColor = UIColor.yellow

UINavigationBar.appearance().barTintColor = UIColor(red: 46.0/255.0, green: 14.0/255.0, blue: 74.0/255.0, alpha: 1.0)
UINavigationBar.appearance().tintColor = UIColor.whiteColor()
UINavigationBar.appearance().titleTextAttributes = [NSForegroundColorAttributeName : UIColor.whiteColor()]
===============================================================================
RootSet
————

func navTabBar()
    {
        let mainVC = SJSwiftSideMenuController()
        let sideVC_L : MenuVC = (storyboard!.instantiateViewController(withIdentifier: "MenuVC") as? MenuVC)!
        let sideVC_R : MenuVC = (storyboard!.instantiateViewController(withIdentifier: "MenuVC") as? MenuVC)!
        var rootVC = UIViewController()
        rootVC = storyboard!.instantiateViewController(withIdentifier: "TabBarController") as! UITabBarController
        SJSwiftSideMenuController.setUpNavigation(rootController: rootVC, leftMenuController: sideVC_L, rightMenuController: sideVC_R, leftMenuType: .SlideView, rightMenuType: .SlideView)
        SJSwiftSideMenuController.enableSwipeGestureWithMenuSide(menuSide: .LEFT)
        SJSwiftSideMenuController.enableDimbackground = false
        SJSwiftSideMenuController.leftMenuWidth = 300
        UIApplication.shared.keyWindow?.rootViewController = mainVC
        
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        appDelegate.window?.rootViewController = mainVC
        appDelegate.window?.makeKeyAndVisible()
    }
===============================================================================
func setTableViewFrame()
 {
        let barHeight: CGFloat = UIApplication.shared.statusBarFrame.size.height + (self.navigationController?.navigationBar.frame.height ?? 0.0)!
        let displayWidth: CGFloat = self.view.frame.width
        let displayHeight: CGFloat = self.view.frame.height
        //let searchHeight: CGFloat = self.searchBar.frame.height
        let tabHeight: CGFloat = (self.tabBarController?.tabBar.frame.height ?? 0.0)!
        
        print("Bar: \(barHeight)\nDWidth: \(displayWidth)\nDHeight: \(displayHeight)\nSerach: \(searchHeight)\ntab: \(tabHeight)")

	childView.frame = CGRect(x: 0, y: barHeight, width: displayWidth, height: displayHeight - tabHeight)

	self.View.addSubview(childView)
}

=================================================================================
<key>NSCameraUsageDescription</key>
	<string>Record Video And Capture Picture Using Camera for Collage</string>
	<key>NSMicrophoneUsageDescription</key>
	<string>Record Video</string>
	<key>NSPhotoLibraryUsageDescription</key>
	<string>Load Picture from Camera Roll for Collage</string>
<key>NSPhotoLibraryAddUsageDescription</key>
	<string>Save Media</string>

=================================================================================

Save Multiple image and video on api
———————————————————
func postImToServer(_ url: NSString, image: NSMutableArray, parameters: NSDictionary!, completionHandler:@escaping (NSDictionary?, NSError?)->())->(){
        
        print("Requesting \( url)")
        print("Parameters: \(parameters!)")
        
        //        let imageData  = UIImagePNGRepresentation(image)
        
        if (image.count > 0)
        {
            manager.post(url as String, parameters: parameters!, constructingBodyWith: { (formData: AFMultipartFormData!) -> Void in
                for i in 0..<image.count {
                    if(((image[i] as! NSDictionary).allKeys[0] as! String) == "image"){
                        formData.appendPart(withFileData: (image[i] as! NSDictionary).allValues[0] as! Data, name: "filedata_\(i)", fileName: "photo\(i).jpg", mimeType: "image/jpeg")
                    }
                    else {
                        formData.appendPart(withFileData: (image[i] as! NSDictionary).allValues[0] as! Data, name: "filedata_\(i)", fileName: "video\(i).mp4", mimeType: "video/mp4")
                    }
                }
            }, success: { (operation, responseData : Any!) -> Void in
                var responseDict : NSDictionary!
                if((responseData as AnyObject).count > 0) {
                    
                    responseDict = responseData as! NSDictionary
                    print(responseDict)
                    completionHandler(responseDict,nil)
                    
                }
            },
               failure: { (operation, error : Error) -> Void in
                completionHandler(nil, error as NSError?)
            })
        }
    }

===================================================================================
Get Application version
————————————
let nsObject: AnyObject? = Bundle.main.infoDictionary!["CFBundleShortVersionString"] as AnyObject?
          print(nsObject as! String)
====================================================================================
Save video path
————————
//            let vPath = NSSearchPathForDirectoriesInDomains(.documentDirectory, .userDomainMask, true)
//            let docsDir = vPath[0]
//            let videoName = "video" + AppUtilities.dateTime() + ".mp4"
//            let outputFilePath = URL(fileURLWithPath: docsDir).appendingPathComponent(videoName).absoluteString
//            videoData?.write(toFile: outputFilePath, atomically: false)
//            self.videoPath = outputFilePath
//            print(self.videoPath)

===================================================================================

//GetImage From Device
—————————————
    func getImage(_ imageName: String) -> UIImage
    {
        var image = UIImage()
        let fileManager = FileManager.default
        let imagePath = (self.getDirectoryPath() as NSString).appendingPathComponent(imageName)
        print("ImagePath: ", imagePath)
        
        if fileManager.fileExists(atPath: imagePath)
        {
            image = UIImage(contentsOfFile: imagePath)!
        }
        else
        {
            print("No Image")
        }
        return image
    }    
    
    func getDirectoryPath() -> String
    {
        let paths = NSSearchPathForDirectoriesInDomains(.documentDirectory, .userDomainMask, true)
        let documentsDirectory = paths[0]
        return documentsDirectory
    }
====================================================================================
Capture Images Front and Rear Camera Without Access Camera
————————————————————————————————

import AVFoundation
import Photos

var session: AVCaptureSession?
var isFront = Bool()
var isBack = Bool()
var arrayImageName = [Any]()

@IBAction func ActionAlarm(_ sender: UIButton)
    {
        isFront = false
        isBack = true
        self.arrayImageName = []
        captureImage(position: .front)        
    }

func captureImage(position: AVCaptureDevice.Position)
    {
        // Get all cameras in the application and find the frontal camera.
        var frontalCamera: AVCaptureDevice?
        var allCameras = AVCaptureDevice.devices(for: .video)
        
        // Find the frontal camera.
        for i in 0..<allCameras.count
        {
            let camera = allCameras[i] as? AVCaptureDevice
            if camera?.position == position
            {
                frontalCamera = camera
            }
        }
        
        // If we did not find the camera then do not take picture.
        if frontalCamera != nil
        {
            // Start the process of getting a picture.
            session = AVCaptureSession()
            
            // Setup instance of input with frontal camera and add to session.
            var error: Error?
            let input = try? AVCaptureDeviceInput(device: frontalCamera!)
            if error == nil && session!.canAddInput(input!)
            {
                // Add frontal camera to this session.
                session?.addInput(input!)
                // We need to capture still image.
                let output = AVCaptureStillImageOutput()
                // Captured image. settings.
                output.outputSettings = [ AVVideoCodecKey : AVVideoCodecType.jpeg ]
                
                if (session?.canAddOutput(output))!
                {
                    session?.addOutput(output)
                    var videoConnection: AVCaptureConnection? = nil
                    for connection: AVCaptureConnection? in output.connections
                    {
                        for port: AVCaptureInput.Port? in connection?.inputPorts ?? [AVCaptureInput.Port?]()
                        {
                            if port?.mediaType == .video
                            {
                                videoConnection = connection
                                break
                            }
                        }
                        if videoConnection != nil
                        {
                            break
                        }
                    }
                    
                    // Finally take the picture
                    if (videoConnection != nil)
                    {
                        session?.startRunning()
                        sleep(0)
                        
                        output.captureStillImageAsynchronously(from: videoConnection!) { (imageDataSampleBuffer, error) in
                           
                            if imageDataSampleBuffer != nil
                            {
                                let imageData: Data? = AVCaptureStillImageOutput.jpegStillImageNSDataRepresentation(imageDataSampleBuffer!)
                                
                                var photo: UIImage?
                                if let aData = imageData
                                {
                                    photo = UIImage(data: aData)
                                }
                                print(String(format: "photo", photo!))

                                let paths = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first!
                                let fileName = self.getFileName()
                                let fileURL = paths.appendingPathComponent(fileName!)
                                self.arrayImageName.append(fileName!) //GetImage
                                print("Count file", self.arrayImageName.count)
                                print("URL: ", fileURL)
                                
                                var imageData1 = Data()
                                if let aPhoto = UIImageJPEGRepresentation(photo!, 1.0) //.uiImageJPEGRepresentation() as? Data
                                {
                                    do
                                    {
                                        imageData1 = aPhoto
                                        try imageData1.write(to: fileURL)
                                        print("file saved")
                                        self.isFront = true
                                        
                                        if self.isFront == true && self.isBack == true
                                        {
                                            self.captureImage(position: .back)
                                            self.isBack = false
                                        }
                                        
                                        if self.arrayImageName.count == 2
                                        {
                                            self.saveImage()
                                        }
                                    }
                                    catch
                                    {
                                        print("error saving file:", error)
                                    }
                                }//SavePhoto
                            }//Output Loop
                        }//Videoconnect
                    }//Take Picture
                }//Output
            }//Input
        }//FrontCamera
    }

====================================================================================

Set Gradient In Text
——————————-
extension UILabel {
    func setTextColorToGradient(image: UIImage) {
        UIGraphicsBeginImageContext(frame.size)
        image.draw(in: bounds)
        let myGradient = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()

        self.textColor = UIColor(patternImage: myGradient!)
    }
}

//use
Label.setTextColorToGradient(image: UIImage(named: "gradientText")!)


====================================================================================

Count 24 Hours
————————

func changeFreeImageEveryDay()
    {
        let userDefaults = UserDefaults.standard
        
        if let lastRetrieval = userDefaults.dictionary(forKey: "lastRetrieval")
        {
            if let lastDate = lastRetrieval["date"] as? NSDate
            {
                if let index = lastRetrieval["index"] as? Int
                {
                    print("LastfreeImage: \(lastRetrieval)")
                    if abs(lastDate.timeIntervalSinceNow) > 86400 { // seconds in 24 hours
                        // Time to change the label
                        freeImgIndexChange = index + 1
                        
                        // Check to see if next incremented index is out of bounds
                        if self.idsSerwer.count <= freeImgIndexChange {
                            // Move index back to zero? Behavior up to you...
                            freeImgIndexChange = 0
                        }
                        
                        let lastRetrieval : [NSObject : AnyObject] = [
                            "date" as NSObject : NSDate(),
                            "index" as NSObject : freeImgIndexChange as AnyObject
                        ]
                        
                         print("LastNewfreeImage: \(lastRetrieval)")
                        
                        userDefaults.set(lastRetrieval, forKey: "lastRetrieval")
                        userDefaults.synchronize()
                    }
                    // Do nothing, not enough time has elapsed to change labels
                }
            }
        }
        else
        {
            // No dictionary found, show first quote
            // Make new dictionary and save to NSUserDefaults
            let lastRetrieval : [NSObject : AnyObject] = [
                "date" as NSObject : NSDate(),
                "index" as NSObject : 0 as AnyObject
            ]
            
            print(lastRetrieval)
            
            userDefaults.set(lastRetrieval, forKey: "lastRetrieval")
            userDefaults.synchronize()
        }
    }
=================================================================================
Extension For Date and Time
———————————————
func getDateTime(_ date: String, _ time: String) -> String
    {
        let dateFormatter = DateFormatter()
        
        //Date  "2018-08-21"
        dateFormatter.dateFormat = "yyyy-mm-dd" //"dd-MM-yyyy"
        let dat = dateFormatter.date(from: date)
        dateFormatter.dateFormat = "mm/YY"
        let d: String = dateFormatter.string(from: dat!)
        print("date is \(d)")
        
        //Time "14:15:00"
        dateFormatter.dateFormat = "H:mm:ss"
        let time12 = dateFormatter.date(from: time)
        dateFormatter.dateFormat = "h:mma"
        let t: String = dateFormatter.string(from: time12!)
        print("date is \(t)")
        
        let dt: String = "\(d) @\(t)"
        
        return dt
    }
=================================================================================
Add Comma in decimal and Int
__________________________________
//Add Comma in numeric -> use -> let number = 31908551587 -> print(number.delimiter) // 31,908,551,587
extension Int
{
    private static var numberFormatter: NumberFormatter =
    {
        let numberFormatter = NumberFormatter()
        numberFormatter.numberStyle = .decimal
        
        return numberFormatter
    }()
    
    var delimiter: String
    {
        return Int.numberFormatter.string(from: NSNumber(value: self)) ?? ""
    }
}

extension Double
{
    static let twoFractionDigits: NumberFormatter =
    {
        let formatter = NumberFormatter()
        formatter.numberStyle = .decimal
        formatter.minimumFractionDigits = 2
        formatter.maximumFractionDigits = 2
        return formatter
    }()
    var formatted: String
    {
        return Double.twoFractionDigits.string(for: self) ?? ""
    }
}
=================================================================================
OPEn General
———————
let alertController = UIAlertController(title: "Internet Alert", message: "You need to internet Connection", preferredStyle: .alert)
            
            let settingsAction = UIAlertAction(title: "OPEN SETTING", style: .default) { (_) -> Void in
                guard let settingsUrl = URL(string: "App-Prefs:root=General") else
                {
                    return
                }
                
                if UIApplication.shared.canOpenURL(settingsUrl)
                {
                    UIApplication.shared.openURL(URL(string: "App-Prefs:root=General")!)
                }
            }
            
            let cancelAction = UIAlertAction(title: "NO", style: .default, handler: nil)
            alertController.addAction(cancelAction)
            alertController.addAction(settingsAction)
            
            self.present(alertController, animated: true, completion: nil)
=================================================================================
extension UIApplication //RootViewController
{
    class func topViewController(controller: UIViewController? = UIApplication.shared.keyWindow?.rootViewController) -> UIViewController?
    {
        if let navigationController = controller as? UINavigationController
        {
            return topViewController(controller: navigationController.visibleViewController)
        }
        if let tabController = controller as? UITabBarController
        {
            if let selected = tabController.selectedViewController
            {
                return topViewController(controller: selected)
            }
        }
        if let presented = controller?.presentedViewController
        {
            return topViewController(controller: presented)
        }
        return controller
    }
}

//use
UIApplication.topViewController()?.present(viewController, animated: true, completion: nil)
=================================================================================
=================================================================================

extension Bundle {
    var releaseVersionNumber: String? {
        return infoDictionary?["CFBundleShortVersionString"] as? String
    }
    var buildVersionNumber: String? {
        return infoDictionary?["CFBundleVersion"] as? String
    }
}









