## pwdc

This tool will take the current directory and puts it on the clipboard.

### Limitations

- Nix devShell only works on mac
- No nix package include

### Use in home-manager

```
  pwdc = import (builtins.fetchGit {
      url = "https://github.com/JeroenKnoops/pwdc";
      rev = "0bc5371bdd760b1056b227487842be4fdaa07e7c";
  }) {};
```

...

```
    home.packages = [
      pwdc
      pkgs.fzf
      ....
```
