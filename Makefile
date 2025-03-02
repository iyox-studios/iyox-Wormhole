.PHONY: pubspecJSON
pubspecJSON:
	cat pubspec.lock | yq . > pubspec.lock.json