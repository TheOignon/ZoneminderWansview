> :warning: I'm not a perl nor nodejs developer

# Compatibility

Those scripts have been tested and are currently used with a Wansview Q3 camera. Some older camera may not be compatible.

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
