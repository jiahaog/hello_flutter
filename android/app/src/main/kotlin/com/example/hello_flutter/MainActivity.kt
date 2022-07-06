package com.example.hello_flutter

import io.flutter.embedding.android.FlutterActivity

class MainActivity : FlutterActivity() {
  // By default, FlutterActivity will create a FlutterEngine in onCreate.
  // Since we have already created one in MainApplication, we want to reuse
  // it. To do so, override the cache id.
  override fun getCachedEngineId() = CACHE_ID
}
