DBPathRecognizer
================

##Demo

![ScreenShot](https://raw.github.com/didierbrun/DBPathRecognizer/master/Assets/screencast.gif)

##Installation

Simply add the file DBPathRecognizer.swift to your project

##Usage

Start by creating a new DBPathRecognizer instance

```
// Create the path 8-directions path recognizer with a delta move sensibility of 16 pt
let recognizer = DBPathRecognizer(sliceCount: 8, deltaMove: 16.0)
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

Note that you can specify a max cost to recognize the gesture :

```
let recognizer = DBPathRecognizer(sliceCount: 8, deltaMove: 16.0, costMax: 40)
```


