package com.example.hello_flutter

import android.app.Application
import io.flutter.embedding.engine.FlutterEngine
import io.flutter.embedding.engine.FlutterEngineCache
import io.flutter.embedding.engine.dart.DartExecutor.DartEntrypoint
import io.flutter.plugin.common.MethodCall
import io.flutter.plugin.common.MethodChannel
import io.flutter.plugin.common.MethodChannel.MethodCallHandler
import io.flutter.plugin.common.MethodChannel.Result
import io.flutter.plugin.common.StandardMethodCodec

val CACHE_ID = "sharedCacheId"

class MainApplication : Application() {
  // Start the Flutter engine (and corresponding Dart entrypoint) earlier.
  override fun onCreate() {
    val cache = FlutterEngineCache.getInstance()

    val engine = FlutterEngine(this, null, /* automaticallyRegisterPlugins= */ false)
    cache.put(CACHE_ID, engine)

    val binaryMessenger = engine.getDartExecutor().getBinaryMessenger()
    val taskQueue = binaryMessenger.makeBackgroundTaskQueue()

    val handler =
      object : MethodCallHandler {
        override fun onMethodCall(call: MethodCall, result: Result) {
          result.success(null)
        }
      }

    // This method channel uses the background task queue, so it should not be
    // dependent on the main thread. In practice, it is actually blocked by the
    // sleep below, and I think this is a bug.
    val channel = MethodChannel(binaryMessenger, "foo", StandardMethodCodec.INSTANCE, taskQueue)
    channel.setMethodCallHandler(handler)

    // Dart main starts on its UI thread here.
    engine.getDartExecutor().executeDartEntrypoint(DartEntrypoint.createDefault())

    // This will delay activityResume and block the main thread.
    Thread.sleep(3000)
  }
}
