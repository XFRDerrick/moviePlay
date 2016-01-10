//
//  ViewController.swift
//  swift_PlayMV
//
//  Created by 赫腾飞 on 16/1/7.
//  Copyright © 2016年 hetefe. All rights reserved.
//

import UIKit

import MediaPlayer

import AVKit

//AVPlayerViewControllerDelegate,
class ViewController: UIViewController ,AVPlayerViewControllerDelegate,UIImagePickerControllerDelegate ,UINavigationControllerDelegate{

    @IBOutlet weak var iconView: UIImageView!
    var vc: MPMoviePlayerController?
    
    var pvc: AVPlayerViewController?
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        
        super.didReceiveMemoryWarning()
        
    }
    
    @IBAction func play1(sender: UIButton) {
        
//       playDemo4()
        screenshots()
        
        
    }
    
    //MARK:- 导出视频
    private func screenshots(){
    
        let vc = UIImagePickerController()
        //设置VC的属性
        vc.mediaTypes = UIImagePickerController.availableMediaTypesForSourceType(UIImagePickerControllerSourceType.PhotoLibrary)!
        
        vc.delegate = self
        
        self .presentViewController(vc, animated: true, completion: nil)
        
    
    }
    //代理方法
    func imagePickerController(picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : AnyObject]) {
        
        //创建导出对象
        let url = info[UIImagePickerControllerMediaURL]
        
        if url == nil {
        
            print("没有视频")
        
            return
        }
        
        let asset = AVAsset(URL: url as! NSURL)
        
        let session = AVAssetExportSession(asset: asset, presetName: AVAssetExportPresetLowQuality)
        
        //设置导出位置
        let path = NSSearchPathForDirectoriesInDomains(.DesktopDirectory, .UserDomainMask, true).last
    
//        path = path?.stringByAppendingPathComponent("daochu.mp4") 使用以下代替
        
        var outUrl = NSURL(fileURLWithPath: path!)
        
        outUrl = outUrl.URLByAppendingPathComponent("daochu.mp4")
        
        print(outUrl)
        
        session?.outputURL = outUrl
        session?.outputFileType = AVFileTypeQuickTimeMovie
        
        session?.exportAsynchronouslyWithCompletionHandler({ () -> Void in
             print("导出完成")
        })
        
    }
    
    
    
      //MARK:- 截图 截取视频某一时刻的截图
    private func playDemo4(){
    
        //创建截图对象
        let path = NSBundle.mainBundle().pathForResource("Cupid_高清.mp4", ofType: nil)
        
        let url = NSURL(fileURLWithPath: path!)
        
        let asset = AVAsset(URL: url)
        
        let gen = AVAssetImageGenerator(asset: asset)
        
        //截图  time 必须是20.9 是带有小数 类型的
        gen.generateCGImagesAsynchronouslyForTimes([20.2]) { (_, image, actualTime, AVAssetImageGeneratorResult, error) -> Void in
            
            
            dispatch_sync(dispatch_get_main_queue(), { () -> Void in
            
                if image != nil {
                
                    self.iconView.image = UIImage(CGImage: image!)
                
                }
                print(image)
                
            })
        }
        
    
    }
    
    
    
     //MARK:- 画中画
    
    private func playDemo3(){
    
        let path = NSBundle.mainBundle().pathForResource("Cupid_高清.mp4", ofType: nil)
        
        let url = NSURL(fileURLWithPath: path!)
        
        let vc = AVPlayerViewController()
        
        self.pvc = vc
        
        vc.delegate = self
        
        vc.player = AVPlayer(URL: url)
        
        vc.player?.play()
        
        presentViewController(vc, animated: true, completion: nil)
    
    }
    func playerViewControllerShouldAutomaticallyDismissAtPictureInPictureStart(playerViewController: AVPlayerViewController) -> Bool {
        return false
    }
    
    
    //MARK:- 播放视频demo 自动播放下一首
    private func playDemo2(){
        
        let path = NSBundle.mainBundle().pathForResource("Cupid_高清.mp4", ofType: nil)
        
        let url = NSURL(fileURLWithPath: path!)
        
        let vc = MPMoviePlayerController(contentURL: url)
        
        self.vc = vc
        
        vc.view.frame = CGRectMake(0, 0, 375, 300)
        
        self.view.addSubview(vc.view)
        
        vc.play()
        
        
        //创建通知实现自动播放下一首
        NSNotificationCenter.defaultCenter().addObserver(self, selector: "didFinishPlay", name: MPMoviePlayerPlaybackDidFinishNotification, object: nil)
    
    }
    
    @objc private func didFinishPlay(){
    
        let path = NSBundle.mainBundle().pathForResource("Alizee_La_Isla_Bonita.mp4", ofType: nil)
        
        let url = NSURL(fileURLWithPath: path!)
        self.vc?.contentURL = url
        
        self.vc?.play()
        
    }

    
    private func playDemo1(){
        
        let path = NSBundle.mainBundle().pathForResource("Cupid_高清.mp4", ofType: nil)
        
        let url = NSURL(fileURLWithPath: path!)
        
        let vc = MPMoviePlayerViewController(contentURL: url)
        
        //        self.presentMoviePlayerViewControllerAnimated(vc)
        
        self.presentViewController(vc, animated: true, completion: nil)
    
    }
    

}

