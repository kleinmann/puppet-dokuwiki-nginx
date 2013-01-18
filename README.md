# dokuwiki Module with nginx support

Uwe Kleinmann <uwe@kleinmann.org>

This module installs dokuwiki with an accompanying nginx vhost via Puppet.

# Requirements

puppet-nginx module (forked because of an outstanding pull request)
- http://github.com/kleinmann/puppet-nginx

# Usage
<pre>
  class { 'dokuwiki':
    domain => 'wiki.example.com',
  }
</pre>
