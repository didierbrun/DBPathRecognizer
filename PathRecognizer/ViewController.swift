//
//  ViewController.swift
//  PathRecognizer
//
//  Created by Didier Brun on 15/03/2015.
//  Copyright (c) 2015 Didier Brun. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    var rawPoints:[Int] = []
    var recognizer:DBPathRecognizer?

    @IBOutlet weak var renderView: RenderView!
    @IBOutlet weak var letter: UILabel!
    
    enum FilterOperation {
        case Maximum
        case Minimum
    }
    
    enum FilterField {
        case LastPointX
        case LastPointY
    }

    override func viewDidLoad() {
        
        let recognizer = DBPathRecognizer(sliceCount: 8, deltaMove: 16.0)
        
        let maxy3 = ViewController.customFilter(self)(.Maximum, .LastPointY, 0.3)
        let miny3 = ViewController.customFilter(self)(.Minimum, .LastPointY, 0.3)
        let maxy7 = ViewController.customFilter(self)(.Maximum, .LastPointY, 0.7)
        let miny7 = ViewController.customFilter(self)(.Minimum, .LastPointY, 0.7)
        
        
        recognizer.addModel(PathModel(directions: [7, 1], datas:"A"))
        recognizer.addModel(PathModel(directions: [2,6,0,1,2,3,4,0,1,2,3,4], datas:"B"))
        recognizer.addModel(PathModel(directions: [4,3,2,1,0], datas:"C"))
        recognizer.addModel(PathModel(directions: [2,6,7,0,1,2,3,4], datas:"D", filter:miny7))
        recognizer.addModel(PathModel(directions: [4,3,2,1,0,4,3,2,1,0], datas:"E"))
        recognizer.addModel(PathModel(directions: [4,2], datas:"F"))
        recognizer.addModel(PathModel(directions: [4,3,2,1,0,7,6,5,0], datas:"G", filter:miny3))
        recognizer.addModel(PathModel(directions: [2,6,7,0,1,2], datas:"H"))
        recognizer.addModel(PathModel(directions: [2], datas:"I"))
        recognizer.addModel(PathModel(directions: [2,3,4], datas:"J"))
        recognizer.addModel(PathModel(directions: [3,4,5,6,7,0,1], datas:"K"))
        recognizer.addModel(PathModel(directions: [2,0], datas:"L"))
        recognizer.addModel(PathModel(directions: [6,1,7,2], datas:"M"))
        recognizer.addModel(PathModel(directions: [6,1,6], datas:"N"))
        recognizer.addModel(PathModel(directions: [4,3,2,1,0,7,6,5,4], datas:"O", filter:maxy3))
        recognizer.addModel(PathModel(directions: [2,6,7,0,1,2,3,4], datas:"P", filter:maxy7))
        recognizer.addModel(PathModel(directions: [4,3,2,1,0,7,6,5,4,0], datas:"Q", filter: maxy3))
        recognizer.addModel(PathModel(directions: [2,6,7,0,1,2,3,4,1], datas:"R"))
        recognizer.addModel(PathModel(directions: [4,3,2,1,0,1,2,3,4], datas:"S"))
        recognizer.addModel(PathModel(directions: [0,2], datas:"T"))
        recognizer.addModel(PathModel(directions: [2,1,0,7,6], datas:"U"))
        recognizer.addModel(PathModel(directions: [1,7,0], datas:"V"))
        recognizer.addModel(PathModel(directions: [2,7,1,6], datas:"W"))
        recognizer.addModel(PathModel(directions: [1,0,7,6,5,4,3], datas:"X"))
        recognizer.addModel(PathModel(directions: [2,1,0,7,6,2,3,4,5,6,7], datas:"Y"))
        recognizer.addModel(PathModel(directions: [0,3,0], datas:"Z"))
        
        
        self.recognizer = recognizer
        
        super.viewDidLoad()

    }
    
    

    
    func minLastY(cost:Int, infos:PathInfos, minValue:Double)->Int {
        var py:Double = (Double(infos.deltaPoints.last!.y) - Double(infos.boundingBox.top)) / Double(infos.height)
        return py < minValue ? Int.max : cost
    }
    
    func maxLastY(cost:Int, infos:PathInfos, maxValue:Double)->Int {
        var py:Double = (Double(infos.deltaPoints.last!.y) - Double(infos.boundingBox.top)) / Double(infos.height)
        return py > maxValue ? Int.max : cost
    }
    
    
    
    func customFilter(operation:FilterOperation,_ field:FilterField, _ value:Double)(cost:Int, infos:PathInfos)->Int {
        
        var pvalue:Double
        
        switch field {
            case .LastPointY:
                pvalue = (Double(infos.deltaPoints.last!.y) - Double(infos.boundingBox.top)) / Double(infos.height)
            case .LastPointX:
                pvalue = (Double(infos.deltaPoints.last!.x) - Double(infos.boundingBox.left)) / Double(infos.width)
        }
        
        switch operation {
            case .Maximum:
                return pvalue > value ? Int.max : cost
            case .Minimum:
                return pvalue < value ? Int.max : cost
        }
    }
    
    
    
    override func touchesBegan(touches: Set<NSObject>, withEvent event: UIEvent) {
        rawPoints = []
        let touch = touches.first as? UITouch
        let location = touch!.locationInView(view)
        rawPoints.append(Int(location.x))
        rawPoints.append(Int(location.y))
    }
    
    override func touchesMoved(touches: Set<NSObject>, withEvent event: UIEvent) {
        let touch = touches.first as? UITouch
        let location = touch!.locationInView(view)
        rawPoints.append(Int(location.x))
        rawPoints.append(Int(location.y))
        
        self.renderView.pointsToDraw = rawPoints
    }
    
    override func touchesEnded(touches: Set<NSObject>, withEvent event: UIEvent) {
        
        
        var path:Path = Path()
        path.addPointFromRaw(rawPoints)
        
        var gesture:PathModel? = self.recognizer!.recognizePath(path)
        
        if gesture != nil {
            letter.text = gesture!.datas as? String
        } else {
            letter.text = "-"
        }
    }
    
    

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }


}

