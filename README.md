> :warning: I'm not a perl nor nodejs developer

# Installation

```Shell
cd /usr/share/zoneminder/www/
git clone https://github.com/TheOignon/ZoneminderWansview.git
cd ZoneminderWansview
apt install nodejs npm
npm install
cp wansview.pm /usr/share/perl5/ZoneMinder/Control
```

# Configuration in ZoneMinder

The Control Address must follow the exact format : `<user>:<password>@<ip>:<port>`