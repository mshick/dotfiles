Dotfiles (mshick)
=================

## install

Run this:

```sh
git clone https://github.com/mshick/dotfiles.git ~/.dotfiles
cd ~/.dotfiles
script/bootstrap
```

This will symlink the appropriate files in `.dotfiles` to your home directory.
Everything is configured and tweaked within `~/.dotfiles`.

`.localrc` sets some personal environment variables, and holds stuff you'd
prefer not to see in a public repository. See the example: `zsh/localrc.example`.

You will need to rename and place in your user dir, at this path: `~/.localrc`

`bin/dot` is a simple script that installs some dependencies, sets sane OS X
defaults, and so on. Tweak this script, and occasionally run `dot` from
time to time to keep your environment fresh and up-to-date. You can find
this script in `bin/`.

`zsh/zshrc.symlink` may also have paths you need to change to get things working
on your system.

## Credit

I forked [Zach Holman](http://github.com/holman)'s dotfiles. Check his repo out
for more information on topical organization and the structure of these files.
