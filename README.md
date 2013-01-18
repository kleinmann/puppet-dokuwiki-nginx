# dokuwiki Module with nginx support

Uwe Kleinmann <uwe@kleinmann.org>

This module installs dokuwiki with an accompanying nginx vhost via Puppet.
It is specifically for Ubuntu 12.10 and hasn't been tested with anything else.

# Usage
<pre>
  class { 'dokuwiki':
    domain     => 'wiki.example.com',
    wiki_email => 'root@wiki.example.com',
    wiki_title => 'Example Wiki',
  }
</pre>
