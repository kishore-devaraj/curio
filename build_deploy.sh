# Install brew
/bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install.sh)"

test -d ~/.linuxbrew && eval $(~/.linuxbrew/bin/brew shellenv)
test -d /home/linuxbrew/.linuxbrew && eval $(/home/linuxbrew/.linuxbrew/bin/brew shellenv)

echo "eval \$($(brew --prefix)/bin/brew shellenv)" >>~/.profile

# Install hugo
brew install hugo

# Generate build
rm public/
hugo

# Push the subtree to the other branch
git subtree push --prefix public origin gh-pages