package io.flutter.plugins;

import io.flutter.plugin.common.PluginRegistry;
import io.flutter.plugins.connectivity.ConnectivityPlugin;
import it.nplace.downloadspathprovider.DownloadsPathProviderPlugin;
import com.amolg.flutterbarcodescanner.FlutterBarcodeScannerPlugin;
import io.endigo.plugins.pdfviewflutter.PDFViewFlutterPlugin;
import io.flutter.plugins.pathprovider.PathProviderPlugin;

/**
 * Generated file. Do not edit.
 */
public final class GeneratedPluginRegistrant {
  public static void registerWith(PluginRegistry registry) {
    if (alreadyRegisteredWith(registry)) {
      return;
    }
    ConnectivityPlugin.registerWith(registry.registrarFor("io.flutter.plugins.connectivity.ConnectivityPlugin"));
    DownloadsPathProviderPlugin.registerWith(registry.registrarFor("it.nplace.downloadspathprovider.DownloadsPathProviderPlugin"));
    FlutterBarcodeScannerPlugin.registerWith(registry.registrarFor("com.amolg.flutterbarcodescanner.FlutterBarcodeScannerPlugin"));
    PDFViewFlutterPlugin.registerWith(registry.registrarFor("io.endigo.plugins.pdfviewflutter.PDFViewFlutterPlugin"));
    PathProviderPlugin.registerWith(registry.registrarFor("io.flutter.plugins.pathprovider.PathProviderPlugin"));
  }

  private static boolean alreadyRegisteredWith(PluginRegistry registry) {
    final String key = GeneratedPluginRegistrant.class.getCanonicalName();
    if (registry.hasPlugin(key)) {
      return true;
    }
    registry.registrarFor(key);
    return false;
  }
}
