# otpless_demo

Requirements

The compileSdk version should be 35.
The minimum SDK version supported by the SDK is 21.
The kotlin version should be 1.9.0 and above.
The gradle version should be 8.3.1 and above.

Add intent filter inside your android/app/src/main/AndroidManifest.xml
<intent-filter>
<action android:name="android.intent.action.VIEW" />
<category android:name="android.intent.category.DEFAULT" />
<category android:name="android.intent.category.BROWSABLE" />
<data
android:host="otpless"
android:scheme= "otpless.YOUR_APP_ID_LOWERCASE"/>## replace your app id here in lower case
</intent-filter>

add below line in your manifest if you are using the SNA feature ##not mandatory
android:networkSecurityConfig="@xml/otpless_network_security_config"

Add this code to your onBackPressed() method in your main activity
override fun onBackPressed() {
val plugin = flutterEngine?.plugins?.get(OtplessFlutterPlugin::class.java)
if (plugin is OtplessFlutterPlugin) {
if (plugin.onBackPressed()) return
}
// handle other cases
super.onBackPressed()
}

