class AudioManager {
// Singleton pattern
static final AudioManager _instance = AudioManager._internal();
factory AudioManager() => _instance;
AudioManager._internal();

bool _isMusicEnabled = true;
bool _isSfxEnabled = true;
double _musicVolume = 0.7;