# Homebrew tap for Notcholino

[Notcholino](https://github.com/Peppe37/Notcholino) is a free and open-source app that turns the notch of your MacBook into a place for what is playing, your calendar, files you are carrying around, device popups and plugins.

## Install

```sh
brew install --cask Peppe37/notcholino/notcholino
```

Use the full name once: it also tells Homebrew you trust this tap. After that, `brew upgrade --cask notcholino` updates it.

To remove it: `brew uninstall --cask notcholino` (add `--zap` to delete its settings and the plugins you installed).

## About this tap

- Notcholino is an alpha and is **not notarized by Apple** yet. Homebrew's official cask repository only takes notarized apps, so for now it lives here. The cask removes the quarantine flag that Homebrew puts on the download, so the app opens normally.
- The cask follows the releases of the app on its own: a workflow checks for a new one every few hours, updates the version and checksum, verifies them against the real DMG, and commits. See [`.github/workflows/update.yml`](.github/workflows/update.yml).
- Every release of the app is flagged as a pre-release for now, which is why Homebrew's own audit complains about it.

Report problems with the app in [its repository](https://github.com/Peppe37/Notcholino/issues), and problems with installing it here.

## License

The files of this tap are MIT. Notcholino itself is GPL-3.0.
