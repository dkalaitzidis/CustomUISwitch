# CustomUISwitch
A custom UIControl class to use as UISwitch from Storyboards or Code.

# Why CustomUISwitch

Hi! Recently i got some mockups for a new iOS from our ninja at **Orfium** (https://www.orfium.com) whose identity shall be kept hidden. 

One of the screens contained a custom UISwitch, this was one of the first things that i started to work on ;)

# What you get
![Custom UISwitch](https://imgur.com/DTfyxYZ.png)


## How to Install


**There is two ways to install this library**

**Manual**
- Simply drag 'n drop the CustomSwitch.swift file to your project
- Download the Assets folder and add them to your project

**CocoaPods**

Add to your podfile
```
pod 'CustomSwitch', '~> 0.1'
```


## How to use

**Storyboard**

- Add a UIView to a UIViewController and change the class to CustomSwitch, done! Some properties are exposed for the user to change them.

**Code**

- Create a CustomSwitch via code:
```
let myCustomSwitch = CustomSwitch(frame: CGRect(x: 50, y: 50, width: 48, height: 14))
self.view.addSubview(myCustomSwitch)
```


**Available Properties**

- animationDuration: Double 
- isOn: Bool
- isOnImage: String 
- isOffImage: String
- onTintColor: UIColor
- offTintColor: UIColor
- padding: CGFloat
- thumbOnTintColor: UIColor
- thumbOffTintColor: UIColor
- thumbTintColor: UIColor
