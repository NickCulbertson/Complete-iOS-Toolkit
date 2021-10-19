# Complete-iOS-Toolkit

(This Project is super outdated now. It might still have some useful bits for people using Objective-C in iOS.)

This project includes the implementation of some of the most popular iOS native features including: 

• Push Notifications
• Ad Banners (Admob) 
• In-App Purchases
• Rate This App
• JSON Data Storage

## Install Instructions
1. Click the "Download Zip" button on the right side of your screen.
2. Edit "local.json"
3. Replace logo.png & background.png
4. Now Build & Run

## Edit "local.json" to customize the app.

"local.json" Key
<pre><code>{
  "AppSettings": [
                  {
                    "AppName":"My App Name", //Enter your app name
                    "HeaderColor":"3", //Choose a number between "1-9" to select a color theme. If you enter "10" you can enter the custom values below
                    "HeaderLabel":"My App", //This is the title that will show in the header of the home screen
                    "TagLine":"NICK CULBERTSON\nDallas App Developers", //This is the label under the logo (type "\n" for a line break like "line one \n line two"
                    "MenuItems":"8" //Enter the # of menu options you want. Note: The number cannot exceed the number of menu items listed bellow.
                    "AdmobAdEnabled":"true",//Enable Admob ads (they can still be removed with IAP)
                    "AdmobAdID":"ca-app-pub-0325717490228488/1458343033", //Enter your Admob ID
                  },
                  {
                    "CustomColorR":"0", //For custom colors enter values between 0-255. Higher values increase saturation of that color.
                    "CustomColorG":"180",
                    "CustomColorB":"40",
                    "CustomColorRShadow":"15",
                    "CustomColorGShadow":"140",
                    "CustomColorBShadow":"20"
                  },
                  { //This is where you enter text for the settings alertview.
                    "AlertTitle":"My Settings", //Alert Title
                    "AlertMessage":"Thanks for checking out the app. Enjoy!", //Alert Message
                    "AlertItems":"5", // Number of Alert Buttons (can't exceed the number of AlertItems
                  },
                  {
                    "PushMessage":"The App has just been updated. See what you have been missing.",
                    "DaysUntilPush":"10", //Days until the push notification is sent
                  },
                  {
                    "IAPMessage":"Enter Prompt",
                    "IAPID":"10",
                  },
                ],
    "MenuItems": [ //These are the menu items in the menu bar.
                  {
                    "MenuTitle":"Home", //Title on menu 
                    "MenuLabel":"My App", // Title of the header after selection is made
                    "MenuURL":"home" //"home" to return to the landing page
                  },
                  {
                    "MenuTitle":"Twitter",
                    "MenuLabel":"My Twitter",
                    "MenuURL":"http://www.twitter.com/" //"http://..." to open a webpage in a webview
                  },
                  {
                    "MenuTitle":"Google",
                    "MenuLabel":"My Google",
                    "MenuURL":"http://www.google.com"
                  },
                  {
                    "MenuTitle":"Facebook",
                    "MenuLabel":"My Facebook",
                    "MenuURL":"https://www.facebook.com/"
                  },
                  {
                    "MenuTitle":"Youtube",
                    "MenuLabel":"My Youtube",
                    "MenuURL":"http://www.youtube.com/"
                  },
                  {
                    "MenuTitle":"Rate",
                    "MenuLabel":"Rate",
                    "MenuURL":"rate" //"rate" takes the user to your app in the store
                  },
                  {
                    "MenuTitle":"Notifications",
                    "MenuLabel":"My Notification",
                    "MenuURL":"notification" //"notification" to enable or disable notifications
                  },
                  {
                    "MenuTitle":"In App Purchase",
                    "MenuLabel":"My IAP",
                    "MenuURL":"iap" //"iap" to initiate an in-app purchase
                  },
                ],
    "AlertItems": [
                  {
                    "AlertButton":"Twitter", //Alert Button Title
                    "AlertURL":"http://www.twitter.com/madcalfapps"
                  },
                  {
                    "AlertButton":"Remove Ads",
                    "AlertURL":"iap"
                  },
                  {
                    "AlertButton":"Rate This App",
                    "AlertURL":"rate"
                  },
                  {
                    "AlertButton":"Notifications",
                    "AlertURL":"notification"
                  },
                  {
                    "AlertButton":"Thanks! Maybe Later",
                    "AlertURL":"cancel"
                  },
                  ],
}</code></pre>


###Color index for "HeaderColor"
<pre><code>1 = Turquoise
2 = Green
3 = Blue
4 = Purple
5 = Navy
6 = Yellow
7 = Orange
8 = Red
9 = Gray
10 = Custom Color //Set by "CustomColor" options</code></pre>


###MenuURL & AlertURL enter one of the following options:
<pre><code>"http://..." to open a webpage in a webview
"home" to return to the landing page
"rate" for a rate prompt
"iap" to initiate an in-app purchase
"notification" to enable or disable notifications</code></pre>


# Push Notifications

1. Create a developer and distribution certificate and provisioning profile enabled with push notifications using your app bundle name.
2. Set the text and schedule for your push notification in the local.json file.

# Ad Banners (Admob) 

1. Create a Google Admob Account (if you have not already).
2. Create a new Ad ID for your app.
3. Copy and Paste your Ad ID into the ######local.json file.

# In-App Purchases

1. Setup an In-App Purchase on iTunesConnect using this url format `@"com.YourDeveloperName.YourAppName.inapp.IAP1"`
2. Select the IAP to be non-consumable (one time purchase).  
3. Change ID In-App Purchase in IAPHelper.m. Find:
`#define kIAPProductIdentifier1 @"com.YourDeveloperName.YourAppName.inapp.IAP1"`

# Rate This App

In the app delegate you can change the number of days and uses until the rate prompt will show.
For full documentation on this refer to Nick Lockwood's iRate. https://github.com/nicklockwood/iRate

# JSON Data

This feature is in Beta. To experiment with it, comment in the code [self GetRemoteJSON]; in the bottom of the - (void)fetchedDataLocal method in ViewController.m. Then set your server jsonURL to #define kjsonURL [NSURL URLWithString: @"http://yourwebsite.com/remote.json"]

