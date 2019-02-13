
See
- https://qiita.com/kaishuu0123/items/00b89e092f156a02a3e5
  Rails 5.1 API mode + webpacker + react + reactstrap で ToDO アプリを書く  

- https://github.com/kaishuu0123/rails5.1-react-reactstrap-example

- https://tackeyy.com/blog/posts/token-base-api-with-rails-and-devise-token-auth
  [Rails5] devise_token_auth でAPIを作成する / 新規登録・ログイン  

- https://www.storyblok.com/tp/rspec-api-documentation
  How we use RSpec to automatically generate API documentations

DB の初期化と、アプリの起動。

```
$ bundle install
$ rails db:delete
$ rails db:create
$ rails db:migrate
$ rails db:seed_fu

$ ./bin/webpack-dev-server
$ rails s
# open http://localhost:3000
```

テストをすると API ドキュメントができる。
(ソースコードとドキュメントがズレることがない)

```
$ rails docs:generate
# then
#   $ rails s
#   open http://localhost:3000/docs
```

その他の各種ツールの実行。

```
$ bundle exec rubocop

$ bundle exec brakeman

$ bundle exec rspec
$ open coverage/index.html

$ bundle exec erd
$ open erd.pdf
```

```
$ rails log:clear
$ rails tmp:clear
```
