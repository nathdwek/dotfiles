DOTFILES_644=
DOTFILES_755=
DOTFILES_644+=.gitconfig
DOTFILES_644+=.gitattributes
DOTFILES_755+=.bashrc
DOTFILES_644+=.dircolors
DOTFILES_644+=.Xmodmap
DOTFILES_BEETS=config.yaml
DOTFILES_ATOM=config.cson

INSTALL = install
INSTALL_DIR=$(HOME)

BEETS_CONFIG_DIR=$(INSTALL_DIR)/.config/beets/
BEETSDIR=$(INSTALL_DIR)/music/beetsdir
ATOMDIR=$(HOME)/.atom/

default:
	echo "This can amongst other things overwrite some of your config files, and will write in your HOMEDIR."
	echo "Nothing done. You can do make install if you know what you're doing."

install:
	$(INSTALL) -m 755 $(DOTFILES_755) $(INSTALL_DIR)
	$(INSTALL) -m 644 $(DOTFILES_644) $(INSTALL_DIR)
	$(INSTALL) -m 644 $(addprefix beets/, $(DOTFILES_BEETS)) $(BEETS_CONFIG_DIR)
	$(INSTALL) -m 644 $(addprefix atom/, $(DOTFILES_ATOM)) $(ATOMDIR)

init: init-beets init-atom

init-beets:
	$(INSTALL) -d $(BEETS_CONFIG_DIR)
	$(INSTALL) -d $(BEETSDIR)

init-atom:
	$(INSTALL) -d $(ATOMDIR)
