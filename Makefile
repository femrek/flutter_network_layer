VERSION_PURE := $(shell grep 'version:' pubspec.yaml | head -1 | awk '{print $$2}')
VERSION := v$(VERSION_PURE)
PACKAGES := flutter_network_layer_core flutter_network_layer_dio

generate_changelogs:
	python3 ./scripts/change_log_reader.py ./CHANGELOG.md $(VERSION) >> tmp
	cat tmp
	python3 ./scripts/change_log_inserter.py tmp $(VERSION) flutter_network_layer_core/CHANGELOG.md
	python3 o/scripts/change_log_inserter.py tmp $(VERSION) flutter_network_layer_dio/CHANGELOG.md
	rm tmp
