install: 
	cd dotfiles && for i in *; do ln -nsf ~/.dotfiles/dotfiles/$$i ~/.$$i; done;
	ln -nsf ~/.dotfiles/dotdirs/vim/ftplugin ~/.vim/ftplugin

uninstall:
	cd dotfiles && for i in *; do rm ~/.$$i; done;
