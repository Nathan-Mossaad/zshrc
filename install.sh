#get new zshrc
mv ~/.zshrc ~/bak.zshrc
curl -o ~/.zshrc "https://raw.githubusercontent.com/Nathan-Mossaad/zshrc/main/.zshrc"

#install zinit
rm -rf ~/.zinit
mkdir ~/.zinit
git clone https://github.com/zdharma/zinit.git ~/.zinit/bin

#set zsh to default shell
chsh -s /bin/zsh

echo "To remove bakups run: rm -r bak.zshrc"
