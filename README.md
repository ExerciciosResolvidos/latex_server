LatexServer
==============
### server to provide image from latex document formulas

 Provides a simple image server to respond an API and render formulas as images

```shell
bundle exec rackup -p 80 -D config.ru
```

```shell
*/2 * * * *  /bin/bash -l -c 'cd /var/www/latex_server_production/current && /usr/local/rvm/gems/ruby-2.3.1@latex_server/bin/bundler exec rack$
```

obs.: use full path of bundler in bundler not found
