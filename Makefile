USERCONFIGS = $(shell find -maxdepth 1 -type d ! -name system ! -name '.*')
user: $(USERCONFIGS)
	@echo "Stowing the user configuration"
	stow --restow --target=${HOME} $+

clean: $(USERCONFIGS)
	@echo "Cleaning user configs"
	stow --delete --target=${HOME} $+


default:
	user
