VERSION_PURE := $(shell grep 'version:' pubspec.yaml | head -1 | awk '{print $$2}')
VERSION := v$(VERSION_PURE)
PACKAGES := flutter_network_layer_core flutter_network_layer_dio

pre_version_commit:
	@git add .
	@git commit -m "chore: ready for version $(VERSION)"

check_pub_publish:
	@echo "Checking if 'pub publish' can be run..."
	@for pkg in $(PACKAGES); do \
		echo "Running dry-run for $$pkg..."; \
		cd $$pkg && dart pub publish --dry-run && cd ..; \
	done
	@for pkg in $(PACKAGES); do \
		echo "Running pubspec version update for $$pkg..."; \
		python3 scripts/pubspec_version_updater.py $$pkg/pubspec.yaml $(VERSION_PURE) \
    done
	@git tag $(VERSION)
	@git cliff -o CHANGELOG.md
	@git add .
	@git commit --amend --no-edit
	@git push origin tag $(VERSION)
