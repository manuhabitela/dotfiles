PATH="$PATH/bin"
PATH="$PATH:/sbin"
PATH="$PATH:/usr/bin"
PATH="$PATH:/usr/game"
PATH="$PATH:/usr/sbin"
PATH="$PATH:/usr/local/bin"
PATH="$PATH:/usr/local/sbin"
PATH="$PATH:/usr/lib/lightdm/lightdm"
PATH="$PATH:/usr/bin/core_perl/"
PATH="$PATH:/usr/local/go/bin"
PATH="$PATH:$BUN_INSTALL/bin"
PATH="$PATH:$HOME/.config/composer/vendor/bin"
PATH="$PATH:$HOME/.local/bin"
PATH="$PATH:~/.console-ninja/.bin"
if [[ -a $HOME/.gem/ruby/3.0.0/bin ]]; then
	PATH="$PATH:$HOME/.gem/ruby/3.0.0/bin"
fi
if [[ -a $HOME/android/sdk ]]; then
	export ANDROID_HOME="$HOME/android/sdk"
	PATH="$PATH:$ANDROID_HOME/emulator"
	PATH="$PATH:$ANDROID_HOME/tools"
	PATH="$PATH:$ANDROID_HOME/tools/bin"
	PATH="$PATH:$ANDROID_HOME/platform-tools"
fi
if [[ -a $HOME/.cargo/bin ]]; then
	PATH="$HOME/.cargo/bin:$PATH"
fi
export NODE_EXTRA_CA_CERTS="$(mkcert -CAROOT)/rootCA.pem"
export CM_LAUNCHER=rofi
export EDITOR=micro
export REACT_EDITOR=code
export PATH="$PATH:$HOME/bin"
export FZF_DEFAULT_COMMAND='fd --type f --strip-cwd-prefix'
export LS_COLORS='no=00;38;5;15:fi=00:rs=0:di=0;33:ln=03:mh=00:pi=48;5;230;38;5;136;01:so=48;5;230;38;5;136;01:bd=;4;230;38;5;142;01:cd=;1;230;38;5;94;01:or=38;5;009;48;5;052:su=48;5;160;38;5;230:sg=48;5;136;38;5;230:ca=30;41:st=33;48;5;234:ow=33;48;5;233:tw=33;48;5;235:ex=0;38;5;111;48;5;234:*.json=0;38;5;201:*.ndjson=0;38;5;201:*.ldjson=0;38;5;201:*.yml=0;38;5;201:*.yaml=0;38;5;201:*.xml=0;38;5;201:*.csv=0;38;5;201:*.pb=0;38;5;201:*.proto=0;38;5;201:*.bson=0;38;5;201:*.txt=0;38;5;197:*.tex=0;38;5;197:*.nfo=0;38;5;197:*.rdf=0;38;5;197:*.doc=0;38;5;197:*.docx=0;38;5;197:*.xls=0;38;5;197:*.xlsx=0;38;5;197:*.odt=0;38;5;197:*.ods=0;38;5;197:*.ppt=0;38;5;197:*.pptx=0;38;5;197:*.pdf=0;38;5;197:*.markdown=0;38;5;197:*.md=0;38;5;197:*README=0;38;5;197:*README.md=0;38;5;197:*README.txt=0;38;5;197:*readme.txt=0;38;5;197:*LICENSE=0;38;5;197:*LICENSE.txt=0;38;5;197:*AUTHORS=0;38;5;197:*COPYRIGHT=0;38;5;197:*CONTRIBUTORS=0;38;5;197:*CONTRIBUTING.md=0;38;5;197:*PATENTS=0;38;5;197:*rc=0;38;5;15;48;5;235:*.cfg=0;38;5;15;48;5;235:*.conf=0;38;5;15;48;5;235:*.log=00;38;5;242:*.bak=00;38;5;242:*.aux=00;38;5;242:*.out=00;38;5;242:*.toc=00;38;5;242:*~=00;38;5;242:*#=00;38;5;242:*.part=00;38;5;242:*.incomplete=00;38;5;242:*.swp=00;38;5;242:*.tmp=00;38;5;242:*.temp=00;38;5;242:*.o=00;38;5;242:*.pyc=00;38;5;242:*.class=00;38;5;242:*.cache=00;38;5;242:*.rdb=00;38;5;242:*.aac=00;38;5;035:*.au=00;38;5;035:*.flac=00;38;5;035:*.mid=00;38;5;035:*.midi=00;38;5;035:*.mka=00;38;5;035:*.mp3=00;38;5;035:*.ogg=00;38;5;035:*.wav=00;38;5;035:*.m4a=00;38;5;035:*.mov=0;38;5;034:*.mpg=0;38;5;034:*.mpeg=0;38;5;034:*.m2v=0;38;5;034:*.mkv=0;38;5;034:*.ogm=0;38;5;034:*.mp4=0;38;5;034:*.m4v=0;38;5;034:*.mp4v=0;38;5;034:*.vob=0;38;5;034:*.qt=0;38;5;034:*.nuv=0;38;5;034:*.wmv=0;38;5;034:*.asf=0;38;5;034:*.rm=0;38;5;034:*.rmvb=0;38;5;034:*.flc=0;38;5;034:*.avi=0;38;5;034:*.fli=0;38;5;034:*.flv=0;38;5;034:*.gl=0;38;5;034:*.m2ts=0;38;5;034:*.divx=0;38;5;034:*.webm=0;38;5;034:*.jpg=00;38;5;040:*.JPG=00;38;5;040:*.jpeg=00;38;5;040:*.gif=00;38;5;040:*.bmp=00;38;5;040:*.pbm=00;38;5;040:*.pgm=00;38;5;040:*.ppm=00;38;5;040:*.tga=00;38;5;040:*.xbm=00;38;5;040:*.xpm=00;38;5;040:*.tif=00;38;5;040:*.tiff=00;38;5;040:*.pxm=00;38;5;040:*.png=00;38;5;040:*.PNG=00;38;5;040:*.svg=00;38;5;040:*.svgz=00;38;5;040:*.mng=00;38;5;040:*.pcx=00;38;5;040:*.dl=00;38;5;040:*.xcf=00;38;5;040:*.xwd=00;38;5;040:*.yuv=00;38;5;040:*.cgm=00;38;5;040:*.emf=00;38;5;040:*.eps=00;38;5;040:*.CR2=00;38;5;040:*.ico=00;38;5;040:*.iso=0;38;5;209:*.dmg=0;38;5;209:*.zip=0;38;5;63:*.tar=0;38;5;63:*.tgz=0;38;5;63:*.lzh=0;38;5;63:*.z=0;38;5;63:*.Z=0;38;5;63:*.7z=0;38;5;63:*.gz=0;38;5;63:*.bz2=0;38;5;63:*.bz=0;38;5;63:*.deb=0;38;5;63:*.rpm=0;38;5;63:*.jar=0;38;5;63:*.rar=0;38;5;63:*.apk=0;38;5;63:*.gem=0;38;5;63:';
export EZA_COLORS='da=38;5;250:ur=38;5;245:uw=38;5;245:ux=39;49;1:ue=39;49;1:gr=38;5;245:gw=38;5;245:gx=39;49;1:tr=38;5;245:tw=38;5;245:tx=39;49;1:su=38;5;245:sf=38;5;245:xa=38;5;245:sn=39;49;0:sb=39;49;0:df=39;49;0:ds=39;49;0:uu=38;5;245:un=38;5;245:gu=38;5;245:gn=38;5;245'
# export FZF_DEFAULT_OPTS='--color=bg+:#3F3F3F,bg:#4B4B4B,border:#6B6B6B,spinner:#98BC99,hl:#719872,fg:#D9D9D9,header:#719872,info:#BDBB72,pointer:#E12672,marker:#E17899,fg+:#D9D9D9,preview-bg:#3F3F3F,prompt:#98BEDE,hl+:#98BC99'
export FZF_DEFAULT_OPTS='--no-bold --color=pointer:#e08700,marker:#E17899,prompt:#59b106,hl+:#8AE234,bg+:#2a2a2a'
