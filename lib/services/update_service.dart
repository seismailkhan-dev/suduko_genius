import 'package:firebase_remote_config/firebase_remote_config.dart';
import 'package:package_info_plus/package_info_plus.dart';
import 'package:shared_preferences/shared_preferences.dart';

class UpdateService {
  static const String _skipKey = 'update_later_timestamp';

  static Future<Map<String, dynamic>?> checkForUpdate() async {
    final prefs = await SharedPreferences.getInstance();
    final skipTimestamp = prefs.getInt(_skipKey);

    if (skipTimestamp != null) {
      final skipDate = DateTime.fromMillisecondsSinceEpoch(skipTimestamp);
      final hrs = DateTime.now().difference(skipDate).inHours;
      if (hrs < 24) {
        return null; // Skipped within last 24h
      }
    }

    final remoteConfig = FirebaseRemoteConfig.instance;
    try {
      await remoteConfig.setConfigSettings(RemoteConfigSettings(
        fetchTimeout: const Duration(seconds: 10),
        minimumFetchInterval: const Duration(hours: 1),
      ));
      await remoteConfig.fetchAndActivate();

      final latestVer = remoteConfig.getString('latest_version');
      final forceUpdate = remoteConfig.getBool('force_update');
      final title = remoteConfig.getString('update_title');
      final features = remoteConfig.getString('update_features');

      if (latestVer.isEmpty) return null;

      final packageInfo = await PackageInfo.fromPlatform();
      final currentVer = packageInfo.version;

      if (_isNewer(latestVer, currentVer)) {
        return {
          'latest_version': latestVer,
          'update_title': title,
          'update_features': features,
          'force_update': forceUpdate,
        };
      }
    } catch (e) {
      // Remote config fetch failed, ignore
    }

    return null;
  }

  static Future<void> remindTomorrow() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setInt(_skipKey, DateTime.now().millisecondsSinceEpoch);
  }

  static bool _isNewer(String latest, String current) {
    if (latest == current) return false;
    final latestParts = latest.split('.').map((s) => int.tryParse(s) ?? 0).toList();
    final currentParts = current.split('.').map((s) => int.tryParse(s) ?? 0).toList();

    for (int i = 0; i < latestParts.length || i < currentParts.length; i++) {
      final l = i < latestParts.length ? latestParts[i] : 0;
      final c = i < currentParts.length ? currentParts[i] : 0;
      if (l > c) return true;
      if (l < c) return false;
    }
    return false;
  }
}
