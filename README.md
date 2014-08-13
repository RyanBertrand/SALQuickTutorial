SALQuickTutorial
================

Show quick tutorials, only once, while the user discovers your app.

Instead of showing a gray overlay before the user can start playing with your app (a common practice as of today), we thought it would be better to show these "tips" as needed according to the usage.

SALQuickTutorial supports showing a view with a title, an image and a message. By default, to close, the user just needs to tap the screen, but you can configure it to work with a dismiss button. Also, you can set a completion block to be called when the view is dismissed.

Here at [Seeking Alpha](http://www.seekingalpha.com) we decided to shift, in our next iOS version, from the gray overlay to the quick tutorials when they are really needed.

We invite you to contribute with our first iOS open source project.

![SALQuickTutorial](https://raw.github.com/seekingalpha/SALQuickTutorial/master/SALQTScreenshot.png)

## Installation
The preferred way to install is using CocoaPods

```ruby
pod 'SALQuickTutorial', '~> 0.2'
```

But if you want to do it manually, just get the files from the folder `SALQuickTutorial` (`SALQuickTutorialViewController.h, SALQuickTutorialViewController.m and SALQuickTutorialViewController.xib`) and add to your project.

## Usage

### The extremely simple way
You can use the class method below, if you just want to show the quick tutorial without customizing too much:

```objective-c
[SALQuickTutorialViewController showIfNeededForKey:@"MyUniqueKey" title:@"This feature is awesome" message:@"It's the best feature ever developed in an iOS app" image:[UIImage imageNamed:@"myFeatureImage"]];
```

Calling this method will:

1. Verify if the user already saw this tutorial, according to the key you pass;
2. In case he didn't, will create the quick tutorial based on the title, message and image you pass. The default configurations are that dismiss is done by tapping anywhere, and no support for completion block when dismissed.

### The simple way

Sometimes, you will want to disable the tap-anywhere-to-dismiss and add a *Got it!* button. Wow, `SALQuickTutorial` supports it! Or, maybe, you want your app to know when the user dismissed it.

```objective-c
    //first, verify if you have shown it already
    if ([SALQuickTutorialViewController needsToShowForKey:@"MyUniqueKey"]) {
        SALQuickTutorialViewController *quickTutorialViewController = [[SALQuickTutorialViewController alloc] initWithKey:@"MyUniqueKey" title:@"This feature is awesome" message:@"It's the best feature ever developed in an iOS app" image:[UIImage imageNamed:@"myFeatureImage"]];

        //if you want to enable dismiss only with the button:
        quickTutorialViewController.dismissesWithButton = YES;

        //if you want to set the completion block:
        [quickTutorialViewController setDidDismissCompletionHandler:^{
            [[[UIAlertView alloc] initWithTitle:@"SALQuickTutorialViewController supports completion block" message:[NSString stringWithFormat:@"Quick tutorial with key %@ was dismissed", @"MyUniqueKey"] delegate:nil cancelButtonTitle:nil otherButtonTitles:@"OK", nil] show];
        }];

        //just show it
        [quickTutorialViewController show];
    }
```
## The horizon

- [x] Dismiss with a button instead of dismiss with tap anywhere
- [x] Set completion block when tutorial is dismissed
- [ ] Blurred background
- [ ] Add support to voice instructions

Your suggestions and contributions are welcome in the [issues tab](https://github.com/seekingalpha/SALQuickTutorial/issues)

## License

SALQuickTutorial is available under the MIT license. See the LICENSE file for more info.
