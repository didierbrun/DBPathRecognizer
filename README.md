DBPathRecognizer
================

##Demo

![ScreenShot](https://raw.github.com/didierbrun/DBPathRecognizer/master/Assets/screencast.gif)

##Installation

Simply add the file DBPathRecognizer.swift to your project

##Usage

Start by creating a new DBPathRecognizer instance

```
// Create the path 8-directions path recognizer with a sensibility of 16 pt
let recognizer = DBPathRecognizer(sliceCount: 8, deltaMove: 16.0)
```

Add some models to recognize and link each model to a data object (AnyObject)

```
recognizer.addModel(PathModel(directions: [7, 1], datas:"A"))
recognizer.addModel(PathModel(directions: [2,6,0,1,2,3,4,0,1,2,3,4], datas:"B"))
recognizer.addModel(PathModel(directions: [4,3,2,1,0], datas:"C"))
```
