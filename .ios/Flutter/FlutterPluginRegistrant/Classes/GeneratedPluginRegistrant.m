//
//  Generated file. Do not edit.
//

#import "GeneratedPluginRegistrant.h"
#import <connectivity/ConnectivityPlugin.h>
#import <downloads_path_provider/DownloadsPathProviderPlugin.h>
#import <flutter_barcode_scanner/FlutterBarcodeScannerPlugin.h>
#import <flutter_pdfview/PDFViewFlutterPlugin.h>
#import <path_provider/PathProviderPlugin.h>

@implementation GeneratedPluginRegistrant

+ (void)registerWithRegistry:(NSObject<FlutterPluginRegistry>*)registry {
  [FLTConnectivityPlugin registerWithRegistrar:[registry registrarForPlugin:@"FLTConnectivityPlugin"]];
  [DownloadsPathProviderPlugin registerWithRegistrar:[registry registrarForPlugin:@"DownloadsPathProviderPlugin"]];
  [FlutterBarcodeScannerPlugin registerWithRegistrar:[registry registrarForPlugin:@"FlutterBarcodeScannerPlugin"]];
  [FLTPDFViewFlutterPlugin registerWithRegistrar:[registry registrarForPlugin:@"FLTPDFViewFlutterPlugin"]];
  [FLTPathProviderPlugin registerWithRegistrar:[registry registrarForPlugin:@"FLTPathProviderPlugin"]];
}

@end
