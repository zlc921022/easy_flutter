package com.ssdk.flutter_movie

import androidx.annotation.NonNull
import com.ssdk.siri.AsrPlugin
import io.flutter.embedding.android.FlutterActivity
import io.flutter.embedding.engine.FlutterEngine
import io.flutter.embedding.engine.plugins.shim.ShimPluginRegistry
import io.flutter.plugins.GeneratedPluginRegistrant

class MainActivity : FlutterActivity() {
    override fun configureFlutterEngine(@NonNull flutterEngine: FlutterEngine) {
        GeneratedPluginRegistrant.registerWith(flutterEngine)
        registerSelfPlugin(flutterEngine)
    }

    private fun registerSelfPlugin(flutterEngine: FlutterEngine) {
        val shimPluginRegistry = ShimPluginRegistry(flutterEngine)
        AsrPlugin.registerWith(shimPluginRegistry.registrarFor("com.ssdk.siri.AsrPlugin"))
    }
}
