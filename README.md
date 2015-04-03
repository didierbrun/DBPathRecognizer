DBPathRecognizer
================

##Demo

![ScreenShot](https://raw.github.com/didierbrun/DBPathRecognizer/master/Assets/screencast.gif)

##Installation

Simply add the file DBPathRecognizer.swift to your project

##Basic usage

Start by creating a new DBPathRecognizer instance

```
// Create the path 8-directions path recognizer with a delta move sensibility of 16 pt
let recognizer = DBPathRecognizer(sliceCount: 8, deltaMove: 16.0)
```

Note that you can specify a max cost to recognize the gestures. It means that if a gesture has a score greater than costMax, it will be ignored. 

```
let recognizer = DBPathRecognizer(sliceCount: 8, deltaMove: 16.0, costMax: 40)
```

Add some path model to the recognizer.
Each path is defined by a direction-sequence and an associated data object (AnyObject).

```
recognizer.addModel(PathModel(directions: [7, 1], datas:"A"))
recognizer.addModel(PathModel(directions: [2,6,0,1,2,3,4,0,1,2,3,4], datas:"B"))
recognizer.addModel(PathModel(directions: [4,3,2,1,0], datas:"C"))
recognizer.addModel(PathModel(directions: [4,3,2,1,0,4,3,2,1,0], datas:"E"))
```

For example, here the model for the letter E :

![ScreenShot](https://raw.github.com/didierbrun/DBPathRecognizer/master/Assets/directions.png)

Record a touch move sequence into the dedicated Path structure :

```
// Create the path
var path:Path = Path()

// Add a point (from touch location)
path.addPoint(PathPoint(x:100, y:100)) 

// You can also use the convenient method addPointFromRaw(var rawDatas:[Int])
path.addPointFromRaw(rawPoints)
```

Finally, tell the recognizer to find the best model :

```
var gesture:PathModel? = self.recognizer!.recognizePath(path)
        
if gesture != nil {
    // The best gesture is recognized
} else {
    // No gesture recognized (score is too low)
}
```

##Custom filter

While adding a model, you can specify a custom filter. The filter callback method, if specified, will let you a last chance to modify / analyze the datas to determine a new score.

For example, the letter D & P have a similar draw-direction-path, however you can discriminate each one by detecting the position of the last point (up -> it's a P, down -> it's a D). The PathInfos struct transmited to the filter function will help you to determine the new score.

Your custom filter function signature should conform to this signature : ((score:Int, infos:PathInfos) -> newScore:Int) :

```
recognizer.addModel(PathModel(directions: [2,6,7,0,1,2,3,4], datas:"P", filter:{
            (cost:Int, infos:PathInfos) -> Int in
                // Determine new cost
                return cost
        }));
```








