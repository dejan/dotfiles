install: 
	cd dotfiles && for i in *; do ln -nsf ~/.dotfiles/dotfiles/$$i ~/.$$i; done;

uninstall:
	cd dotfiles && for i in *; do rm ~/.$$i; done;
