DOTFILES_644=
DOTFILES_755=
DOTFILES_644+=.gitconfig
DOTFILES_644+=.gitattributes
DOTFILES_755+=.bashrc
DOTFILES_644+=.dircolors
DOTFILES_644+=.Xmodmap
DOTFILES_BEETS=config.yaml

INSTALL = install
INSTALL_DIR=$(HOME)
BEETSDIR=$(INSTALL_DIR)/.config/beets/

default:
	echo "This can amongst other things overwrite some of your config files, and will write in your HOMEDIR."
	echo "Nothing done. You can do make install if you know what you're doing."

install:
	$(INSTALL) -m 755 $(addprefix dotFiles/, $(DOTFILES_755)) $(INSTALL_DIR)
	$(INSTALL) -m 644 $(addprefix dotFiles/, $(DOTFILES_644)) $(INSTALL_DIR)
	$(INSTALL) -m 644 $(addprefix dotFiles/beets/, $(DOTFILES_BEETS)) $(BEETSDIR)
