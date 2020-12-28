//
//  AudioViewController.swift
//  AudioRecordDemo


import UIKit
import AVFoundation
import AVKit

class AudioViewController: UIViewController {

    @IBOutlet weak var tblRecord: UITableView!
    
    var avPlayer: AVPlayer!
    
    var playIndexRow: Int = -1
    var oldPlayIndexRow: Int = -1
    
    var curTrack: Float = 0
    var maxTrack: Float = 0
    
    var timer: Timer?
    var isPause = true
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tblRecord.register(UINib(nibName: "PlayTableViewCell", bundle: nil), forCellReuseIdentifier: "PlayTableViewCell")
        tblRecord.delegate = self
        tblRecord.dataSource = self
    }
    
    func play(url: URL) {
        stopTimer()
        
        self.avPlayer = nil
        self.avPlayer = AVPlayer(playerItem: AVPlayerItem(url: url))
        self.avPlayer.automaticallyWaitsToMinimizeStalling = false
        avPlayer!.volume = 1.0
        avPlayer.play()
        
        isPause = false
        setupTimer()
    }
    
    func setupTimer() {
        timer = Timer.scheduledTimer(timeInterval: 0.1, target: self, selector: #selector(tick), userInfo: nil, repeats: true)
    }
    
    @objc func tick() {
        if ((avPlayer.currentItem?.asset.duration) != nil) {
           
            if let _ = avPlayer.currentItem?.asset.duration{}else{return}
            if let _ = avPlayer.currentItem?.currentTime(){}else{return}
           
            let currentTime1 : CMTime = (avPlayer.currentItem?.asset.duration)!
            let seconds1 : Float64 = CMTimeGetSeconds(currentTime1)
            let time1 : Float = Float(seconds1)
            maxTrack = time1
           
            let currentTime : CMTime = (self.avPlayer?.currentTime())!
            let seconds : Float64 = CMTimeGetSeconds(currentTime)
            let time : Float = Float(seconds)
            curTrack = time
            
            if time > time1 {
                self.isPause = true
                self.stopTimer()
            }
            
            self.tblRecord.reloadRows(at: [IndexPath(row: playIndexRow, section: 0)], with: .none)
            
        } else {
            
        }
    }
    
    func stopTimer() {
        timer?.invalidate()
        timer = nil
    }
    
    @objc func onBtnPlayPause(_ sender: UIButton) {
        oldPlayIndexRow = playIndexRow
        
        if oldPlayIndexRow != sender.tag && oldPlayIndexRow != -1 {
            playIndexRow = -1
            self.tblRecord.reloadRows(at: [IndexPath(row: oldPlayIndexRow, section: 0)], with: .none)
        }
        
        playIndexRow = sender.tag
        
        if sender.currentTitle == "Play" {
            let strUrl = arrAudioSong[sender.tag]["url"] as! String
            self.play(url: URL(string: strUrl)!)
            
        } else if sender.currentTitle == "Pause" {
            
            isPause = true
            avPlayer.pause()
            self.stopTimer()
        }
        
        tblRecord.reloadRows(at: [IndexPath(row: playIndexRow, section: 0)], with: .none)
    }
    
    @objc func onSliderChanged(_ sender: UISlider) {
        
        let seconds : Int64 = Int64(sender.value)
        let targetTime:CMTime = CMTimeMake(value: seconds, timescale: 1)
        
        avPlayer!.seek(to: targetTime)
        
        avPlayer!.addPeriodicTimeObserver(forInterval: CMTimeMakeWithSeconds(1, preferredTimescale: 1), queue: DispatchQueue.main) { (CMTime) -> Void in
            if self.avPlayer!.currentItem?.status == .readyToPlay {
                let time : Float64 = CMTimeGetSeconds((self.avPlayer!.currentTime()));
                sender.value = Float ( time );
            }
        }
    }
    
}

extension AudioViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 100
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return arrAudioSong.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tblRecord.dequeueReusableCell(withIdentifier: "PlayTableViewCell") as? PlayTableViewCell else {
            return UITableViewCell()
        }
        
        cell.sliderTrack.minimumValue = 0
        
        if indexPath.row == playIndexRow && !isPause {
            cell.btnPlay.setTitle("Pause", for: .normal)
            cell.sliderTrack.isUserInteractionEnabled = true
            cell.sliderTrack.maximumValue = maxTrack
            cell.sliderTrack.value = curTrack
            cell.lblTime.text = String(format: "%.2f", (maxTrack / 60)).replacingOccurrences(of: ".", with: ":")
            
        } else {
            cell.sliderTrack.isUserInteractionEnabled = false
            cell.btnPlay.setTitle("Play", for: .normal)
            cell.lblTime.text = "0:00"
            cell.sliderTrack.value = 0
        }
        
        cell.btnPlay.tag = indexPath.row
        cell.btnPlay.addTarget(self, action: #selector(onBtnPlayPause(_:)), for: .touchUpInside)
        
        cell.sliderTrack.tag = indexPath.row
        cell.sliderTrack.addTarget(self, action: #selector(onSliderChanged(_:)), for: .valueChanged)
        return cell
    }
}
