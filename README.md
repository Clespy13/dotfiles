# Install

- Clone the repository
- Run this command to switch the config immediately:
```
sudo nixos-rebuild switch --flake .#default
```

- Otherwise run this command to switch the config on the next reboot:
```
sudo nixos-rebuild boot --flake .#default
```

If any errors occur, you are welcome to do a PR or an issue.
You can debug with the `--show-trace` option during rebuild.
