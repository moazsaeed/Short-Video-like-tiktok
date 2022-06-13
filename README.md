# Short-Video-like-tiktok
This is Sample app for playing short videos like tiktok
This app shows the list of video and clicking on any video opens new Screen to play videos and user can continuously scroll to next video.

## Demonstrations

Covers the following:

* Discussions
* Screenshots
* Architecture at a Glance
* Requirements
* Architecture
* ThirdParty Libraries
* How to Run
* Tests
* Author 
* Limitations
* License

## Discussions

I have used `UIKit` for user interface creation, `Combine` allows me to use features like publishers and subscribers. Used `MVVM` Architectural design pattern is for modularized, maintainable and decoupled Codeing, Bindings make UI updates easier to handle etc.
`CompositionalLayouts` for listing, `Diffablle Datasource` for datasource for listings. `AVFoundation` `AVPlayer` for playing video

## Screenshots

|             Articles List         |         ArticleDetail          | 
|---------------------------------|------------------------------|
|![Demo](https://github.com/moazsaeed/Short-Video-like-tiktok/blob/main/Screenshots/list.png)|![Demo](https://github.com/moazsaeed/Short-Video-like-tiktok/blob/main/Screenshots/player.png)|

## Architecture at a Glance

![Architecture at a Glance](https://github.com/moazsaeed/Short-Video-like-tiktok/blob/main/Screenshots/mvvm.jpeg)

## Requirements

- Xcode 13.1
- Cocoapods 1.11.2
- Swift 5.0
- Minimum iOS version 15.0

## Architecture
1. MVVM (Model View ViewModel)

## ThirdParty Libraries
- Kingfisher (for image loading and caching)
- KRProgressHUD (for progress hud while processing in the app)

## How to Run
- clone the repository or download the zip file
- open terminal and go to project directory
- run command `pod install` to install the dependencies
- Run the project

## Tests
not added yet

## Author

moazsaeed, moazsaeed@live.com

## Limitations
API has limited number of videos. you can only scrolll through available number of videos.

## License

This is available under the MIT license. See the LICENSE file for more info.


