# flutter_local_notifications: keep the plugin's own classes and the manifest
# receiver reachable via reflection when the scheduled "rest complete" alarm
# fires while the app is backgrounded/killed.
# https://github.com/MaikuB/flutter_local_notifications
-keep class com.dexterous.flutterlocalnotifications.** { *; }
-keep class com.dexterous.flutterlocalnotifications.models.** { *; }

# in_app_purchase_android wraps Google Play Billing; keep the billing client's
# API surface so R8 doesn't strip classes it invokes via callbacks/reflection.
# https://developer.android.com/google/play/billing/integrate#proguard
-keep class com.android.billingclient.api.** { *; }
-keep class com.android.vending.billing.** { *; }

# sqflite talks to Android's built-in SQLite through a thin plugin layer with
# no model reflection, but keep its own classes defensively for consistency
# with the other native-channel plugins above.
# https://github.com/tekartik/sqflite
-keep class com.tekartik.sqflite.** { *; }
