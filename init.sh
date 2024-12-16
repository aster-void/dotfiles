# if [ ! $(nix-channel --list | grep "home-manager" | wc -l) == 0 ]; then
  # echo "skipping home manager initialization"
  # exit 0
# fi
nix-channel --add https://github.com/nix-community/home-manager/archive/master.tar.gz home-manager && \
nix-channel --update && \

./.config/home-manager/init.sh

nix-shell -p stow --run 'stow .'
nix-shell -p home-manager --run 'home-manager switch'
