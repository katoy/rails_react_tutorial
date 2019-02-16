
See
- https://qiita.com/kaishuu0123/items/00b89e092f156a02a3e5
  Rails 5.1 API mode + webpacker + react + reactstrap で ToDO アプリを書く  

- https://github.com/kaishuu0123/rails5.1-react-reactstrap-example
  Rails 5.1 + webpacker + react + reactstrap Example

- https://tackeyy.com/blog/posts/token-base-api-with-rails-and-devise-token-auth
  [Rails5] devise_token_auth でAPIを作成する / 新規登録・ログイン  

- https://www.storyblok.com/tp/rspec-api-documentation
  How we use RSpec to automatically generate API documentations

- https://github.com/everydayrails/everydayrails-rspec-2017
  Everyday Rails Testing with RSpec sample application (2017 edition)

- https://techracho.bpsinc.jp/hachi8833/2018_01_25/51101
  Rails 5.1以降のシステムテストをRSpecで実行する（翻訳）

- https://qiita.com/g-fujioka/items/091c400814800f1280ff
  Capybara+headless-chrome でフルサイズのスクリーンショットを撮る

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

spec/acceptance のテストを実行すると API ドキュメントができる。
(ソースコードとドキュメントがズレることがない)

```
$ rails docs:generate
# then
#   $ rails s
#   open http://localhost:3000/docs
```

テストの実行 (chrome headless で起動して system エストも行っている)

```
$ brew install chromedriver
$ bundle exec rspec
$ open coverage/index.html
$ open screenshots/*.png
```

![screenshots/home.png](screenshots/home.png)


その他の各種ツールの実行。

```
$ bundle exec rubocop

$ bundle exec brakeman

$ bundle exec erd
$ open erd.pdf
```

```
$ rails log:clear
$ rails tmp:clear
```
