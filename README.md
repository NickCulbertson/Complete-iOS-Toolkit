# Complete-iOS-Toolkit
This project includes the implementation of some of the most popular iOS native features including: 

######• In-App Purchases
######• Ad Banners (Admob) 
######• Push Notifications
######• Rate This App
######• JSON Data Storage

## Edit "local.json" to customize the app.

######"local.json" Key
<pre><code>{
  "AppSettings": [
                  {
                    "AppName":"My App Name", //Enter your app name
                    "HeaderColor":"3", //Choose a number between "1-9" to select a color theme. If you enter "10" you can enter the custom values below
                    "HeaderLabel":"My App", //This is the title that will show in the header of the home screen
                    "TagLine":"NICK CULBERTSON\nDallas App Developers", //This is the label under the logo (type "\n" for a line break like "line one \n line two"
                    "MenuItems":"8" //Enter the # of menu options you want. Note: The number cannot exceed the number of menu items listed bellow.
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
                    "AlertTitle":"My Settings",
                    "AlertMessage":"Thanks for checking out the app. Enjoy!",
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
                    "MenuTitle":"Alert",
                    "MenuLabel":"My Alert",
                    "MenuURL":"alert" 
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
                    "AlertTitle":"Twitter",
                    "AlertButton":"My Twitter",
                    "AlertURL":"http://www.twitter.com/madcalfapps"
                  },
                  {
                    "AlertTitle":"Google",
                    "AlertButton":"My Google",
                    "AlertURL":"http://www.google.com"
                  },
                  {
                    "AlertTitle":"Facebook",
                    "AlertButton":"My Facebook",
                    "AlertURL":"https://www.facebook.com/pages/Mad-Calf-Apps/179369155500535?fref=nf"
                  },
                  {
                    "AlertTitle":"Youtube",
                    "AlertButton":"My Youtube",
                    "AlertURL":"http://www.youtube.com/"
                  },
                  {
                    "AlertTitle":"Weather",
                    "AlertButton":"Dallas Weather",
                    "AlertURL":"http://m.weather.com/weather/tenday/l/Dallas+TX+USTX0327:1:US"
                  },
                  {
                    "AlertTitle":"Rate",
                    "AlertButton":"Rate",
                    "AlertURL":"rate"
                  },
                  {
                    "AlertTitle":"Alert",
                    "AlertButton":"My Alert",
                    "AlertURL":"alert"
                  },
                  {
                    "AlertTitle":"Notifications",
                    "AlertButton":"My Notification",
                    "AlertURL":"notification"
                  },
                  {
                    "AlertTitle":"In App Purchase",
                    "AlertButton":"My IAP",
                    "AlertURL":"iap"
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
10 = Custom Color //Set by "CustomColor" options
</code></pre>


###MenuURL enter one of the following options:
<pre><code>"http://..." to open a webpage in a webview
"home" to return to the landing page
"rate" for a rate prompt
"iap" to initiate an in-app purchase
"notification" to enable or disable notifications
</code></pre>


# In-App Purchases
All you have to do is change ID in-app Purchase. You can do so by opening IAPHelper.m. Find:

`#define kIAPProductIdentifier1 @"com.MadCalfApps.CompleteiOSToolkit.inapp.IAP1b"`

Example iTunes Connect - Manage In-App Purchases

# Push Notifications


