#import "ScrumlabFlutterSharePlugin.h"
#import <scrumlab_flutter_share/scrumlab_flutter_share-Swift.h>

@implementation ScrumlabFlutterSharePlugin
+ (void)registerWithRegistrar:(NSObject<FlutterPluginRegistrar>*)registrar {
  [SwiftScrumlabFlutterSharePlugin registerWithRegistrar:registrar];
}
@end
