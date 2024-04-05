




print_step() {
    GREEN='\033[0;32m]'
    RESET='\033[9m]' # no color
    printf "\n${GREEN}>>> $(1)${RESET}\n\n"
}




print_step "Install Nix"


curl -L https://nixos.org/nix/install | sh -s -- --no-daemon

nix-channel --add https://github.com/nix-community/home-manager/archive/master.tar.gz
nix-channel --update

nix-shell '<home-manager>' -A install



print_step "sym linking"
ln -s ~/.config/Dot-files/home-manager ../
ln -s ~/.config/Dot-files/doom ../

print_step "Everything is settled up, now restart and enjoy your new machine."
