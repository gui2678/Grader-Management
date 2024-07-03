# Pin npm packages by running ./bin/importmap

pin "application", preload: true
pin "@rails/ujs", to: "https://ga.jspm.io/npm:@rails/ujs@7.0.4/lib/assets/compiled/rails-ujs.js"
pin "turbolinks", to: "https://ga.jspm.io/npm:turbolinks@5.2.0/dist/turbolinks.js"
pin "@rails/activestorage", to: "https://ga.jspm.io/npm:@rails/activestorage@6.1.4/lib/assets/compiled/activestorage.js"
pin "channels", to: "channels/index.js"
