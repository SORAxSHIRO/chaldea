//
//  Generated file. Do not edit.
//

#include "generated_plugin_registrant.h"

#include <catcher/catcher_plugin.h>
#include <connectivity_plus_windows/connectivity_plus_windows_plugin.h>
#include <file_selector_windows/file_selector_plugin.h>
#include <flutter_audio_desktop/flutter_audio_desktop_plugin.h>
#include <flutter_qjs/flutter_qjs_plugin.h>
#include <url_launcher_windows/url_launcher_plugin.h>

void RegisterPlugins(flutter::PluginRegistry* registry) {
  CatcherPluginRegisterWithRegistrar(
      registry->GetRegistrarForPlugin("CatcherPlugin"));
  ConnectivityPlusWindowsPluginRegisterWithRegistrar(
      registry->GetRegistrarForPlugin("ConnectivityPlusWindowsPlugin"));
  FileSelectorPluginRegisterWithRegistrar(
      registry->GetRegistrarForPlugin("FileSelectorPlugin"));
  FlutterAudioDesktopPluginRegisterWithRegistrar(
      registry->GetRegistrarForPlugin("FlutterAudioDesktopPlugin"));
  FlutterQjsPluginRegisterWithRegistrar(
      registry->GetRegistrarForPlugin("FlutterQjsPlugin"));
  UrlLauncherPluginRegisterWithRegistrar(
      registry->GetRegistrarForPlugin("UrlLauncherPlugin"));
}
