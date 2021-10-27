![Huginn](https://raw.github.com/huginn/huginn/master/media/huginn-logo.png "Your agents are standing by.")

-----

This is a fork of Huginn that is deployed using Dokku.

The app can typically be deployed as-is from the primary git repo, but I ran into
an issue with Ruby versions at one point, so here's the fork.

1. git clone git@github.com:iangreenleaf/dokku-huginn.git
2. git remote add dokku dokku@dokku.mydomain.net:huginn
3. dokku apps:create huginn
4. dokku plugin:install https://github.com/dokku/dokku-postgres.git
5. dokku postgres:create huginn
6. dokku postgres:link huginn huginn
7. dokku config:set huginn DATABASE_ADAPTER=postgresql
8. dokku config:set huginn PROCFILE_PATH=deployment/heroku/Procfile.heroku
9. dokku config:set huginn APP_SECRET_TOKEN=my-app-secret
10. dokku config:set huginn RAILS_ENV=production
11. dokku config:set huginn RAILS_SERVE_STATIC_FILES=true
12. git push dokku master
13. dokku domains:set huginn huginn.youngram.com
14. dokku domains:report huginn
15. dokku run huginn bundle exec rake db:migrate
16. dokku run huginn bundle exec rake db:seed
17. dokku ps:restart huginn
18. dokku config:set --no-restart huginn DOKKU_LETSENCRYPT_EMAIL=myemail@example.com
19. dokku letsencrypt huginn
