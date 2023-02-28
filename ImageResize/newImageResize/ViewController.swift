//
//  ViewController.swift
//  newImageResize
//
//  Created by Mohamed Ashik Buhari on 27/02/23.
//

import UIKit

class ViewController: UIViewController {
    
        var BasicView: UIView!
        var ResizeimageView: UIImageView!
        var imageView: UIImageView!
        var RotateimageView: UIImageView!
        var CloseImageImageView: UIImageView!
        
        var deltaAngle: CGFloat!
        var prevPoint: CGPoint!
        var startTransform: CGAffineTransform!
        
    let minWidth: CGFloat = 100.0
    let maxWidth: CGFloat = 200.0
    let minHeight: CGFloat = 100.0
    let maxHeight: CGFloat = 200.0

    
  
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        // Do any additional setup after loading the view.
        
        
        BasicView = UIView(frame: CGRect(x: 100, y: 100, width: 100, height: 100))
        BasicView.backgroundColor = UIColor.clear
        self.view.addSubview(BasicView)


        imageView = UIImageView(frame: CGRect(x: 12, y: 12, width: BasicView.frame.size.width-24, height: BasicView.frame.size.height-27))
        imageView.backgroundColor = UIColor.clear
        imageView.layer.borderColor = #colorLiteral(red: 0.584471643, green: 0.5374109149, blue: 0.06579364091, alpha: 1)
        imageView.layer.borderWidth = 2.0
        imageView.image = UIImage(named: "Mountain")
        BasicView.addSubview(imageView)

        CloseImageImageView = UIImageView(frame: CGRect(x: 0, y: 0, width: 25, height: 25))
        CloseImageImageView.backgroundColor = UIColor.clear
        CloseImageImageView.image = UIImage(named: "close")
        CloseImageImageView.isUserInteractionEnabled = true
        let singleTap = UITapGestureRecognizer(target: self, action: #selector(singleTap(_:)))
        CloseImageImageView.addGestureRecognizer(singleTap)
        BasicView.addSubview(CloseImageImageView)
        
        
        
        ResizeimageView = UIImageView(frame: CGRect(x: BasicView.frame.size.width-25, y: BasicView.frame.size.height-25, width: 25, height: 25))
        ResizeimageView.backgroundColor = UIColor.clear
        ResizeimageView.isUserInteractionEnabled = true
        ResizeimageView.image = UIImage(named: "circle")
        BasicView.addSubview(ResizeimageView)
        let panResizeGesture = UIPanGestureRecognizer(target: self, action: #selector(resizeTranslate(_:)))
        ResizeimageView.addGestureRecognizer(panResizeGesture)

        RotateimageView = UIImageView(frame: CGRect(x: 0, y: BasicView.frame.size.height-25, width: 25, height: 25))
        RotateimageView.backgroundColor = UIColor.clear
        RotateimageView.image = UIImage(named: "rotate")
        RotateimageView.isUserInteractionEnabled = true
        BasicView.addSubview(RotateimageView)
        let panRotateGesture = UIPanGestureRecognizer(target: self, action: #selector(rotateViewPanGesture(_:)))
        RotateimageView.addGestureRecognizer(panRotateGesture)
        panRotateGesture.require(toFail: panResizeGesture)
        
        
        let panGesture = UIPanGestureRecognizer(target: self, action: #selector(moveView(_:)))
        BasicView.addGestureRecognizer(panGesture)
        
        
    }
    
    @objc func moveView(_ gesture: UIPanGestureRecognizer) {
        let translation = gesture.translation(in: view)
        BasicView.center = CGPoint(x: BasicView.center.x + translation.x, y: BasicView.center.y + translation.y)
        gesture.setTranslation(CGPoint.zero, in: view)
    }
    
    
    
    @objc func singleTap(_ recognizer: UIPanGestureRecognizer) {
        
        if let close = recognizer.view as? UIView {
            close.superview?.removeFromSuperview()
        }
        
    }

    
    @objc func resizeTranslate(_ recognizer: UIPanGestureRecognizer) {
        
        
        
        if recognizer.state == .began {
            prevPoint = recognizer.location(in: BasicView.superview)
            BasicView.setNeedsDisplay()
        }
        
        else if recognizer.state == .changed {
            
            
         //   if Minimum and MAximum width and Height requires Use below code
            
//            if BasicView.bounds.size.width < minWidth {
//                BasicView.bounds.size.width = minWidth
//            } else if BasicView.bounds.size.width > maxWidth {
//                BasicView.bounds.size.width = maxWidth
//            }
//
//            if BasicView.bounds.size.height < minHeight {
//                BasicView.bounds.size.height = minHeight
//            } else if BasicView.bounds.size.height > maxHeight {
//                BasicView.bounds.size.height = maxHeight
//            }
            
            
            if BasicView.bounds.size.width < 20 {
                BasicView.bounds = CGRectMake(BasicView.bounds.origin.x,BasicView.bounds.origin.y,  20,  BasicView.bounds.size.height)
                imageView.frame = CGRectMake(12, 12,BasicView.bounds.size.width-24, BasicView.bounds.size.height-27)
                ResizeimageView.frame = CGRectMake(BasicView.bounds.size.width-25, BasicView.bounds.size.height-25,25,  25)
                RotateimageView.frame = CGRectMake( 0, BasicView.bounds.size.height-25, 25,  25)
                CloseImageImageView.frame = CGRectMake( 0, 0, 25, 25)
            }
            
            if BasicView.bounds.size.height < 20 {
                BasicView.bounds = CGRectMake( BasicView.bounds.origin.x, BasicView.bounds.origin.y, BasicView.bounds.size.width,  20)
                imageView.frame = CGRectMake( 12, 12, BasicView.bounds.size.width-24,  BasicView.bounds.size.height-27)
                ResizeimageView.frame = CGRectMake( BasicView.bounds.size.width-25, BasicView.bounds.size.height-25, 25, 25)
                RotateimageView.frame = CGRectMake( 0,  BasicView.bounds.size.height-25,  25,  25)
                CloseImageImageView.frame = CGRectMake( 0,  0,  25, 25)
            }
            
            let point = recognizer.location(in: BasicView.superview)
            var wChange: CGFloat = 0.0
            var hChange: CGFloat = 0.0
            
            wChange = (point.x - prevPoint.x) //Slow down increment
            hChange = (point.y - prevPoint.y) //Slow down increment
            
            BasicView.bounds = CGRectMake( BasicView.bounds.origin.x,  BasicView.bounds.origin.y,  BasicView.bounds.size.width + wChange, BasicView.bounds.size.height + hChange)
            imageView.frame = CGRectMake( 12, 12,  BasicView.bounds.size.width-24, BasicView.bounds.size.height-27)
            
            ResizeimageView.frame = CGRectMake( BasicView.bounds.size.width-25, BasicView.bounds.size.height-25,  25,  25)
            RotateimageView.frame = CGRectMake( 0,  BasicView.bounds.size.height-25, 25,  25)
            CloseImageImageView.frame = CGRect(x: 0, y: 0, width: 25, height: 25)
            
            prevPoint = recognizer.location(in: BasicView.superview)
            
            BasicView.setNeedsDisplay()
        }
        else if recognizer.state == .ended {
            prevPoint = recognizer.location(in: BasicView.superview)
            BasicView.setNeedsDisplay()
        }
        
        
        
        
    }
    
 
    
    
    @objc func rotateViewPanGesture(_ recognizer: UIPanGestureRecognizer) {
        

        if recognizer.state == .began {
            deltaAngle = atan2(CGFloat(recognizer.location(in: BasicView).y - BasicView.center.y), CGFloat(recognizer.location(in: BasicView).x - BasicView.center.x))
            startTransform = BasicView.transform
        } else if recognizer.state == .changed {
            let ang = atan2(CGFloat(recognizer.location(in: BasicView.superview).y - BasicView.center.y), CGFloat(recognizer.location(in: BasicView.superview).x - BasicView.center.x))
            let angleDiff = deltaAngle - ang
            BasicView.transform = CGAffineTransform(rotationAngle: -CGFloat(angleDiff))
            BasicView.setNeedsDisplay()
        } else if recognizer.state == .ended {
            deltaAngle = atan2(CGFloat(recognizer.location(in: BasicView).y - BasicView.center.y), CGFloat(recognizer.location(in: BasicView).x - BasicView.center.x))
            startTransform = BasicView.transform
            BasicView.setNeedsDisplay()
        }

    }

    
                                           


}

