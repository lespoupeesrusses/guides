# Configuration standard pour les projets front-end

## Gestion des assets

Possibilités: Codekit, grunt, gulp, fire.app, Middleman

Solution validée: Middleman

yarn
middleman
bootstrap 4
jquery 

## Livraison

Les projets doivent se livrer pour recette en une ligne de commande :
```
middleman build
```

Pour se faire, nous utilisons la gem middleman sync et un bucket s3 spécifique.
/Gemfile
```
gem 'middleman-s3_sync'
gem 'mime-types'
```

/config.rb (ask @pabois or @arnaudlevy for real data)
```
activate :s3_sync do |s3_sync|
  s3_sync.bucket                     = 'type bucket name here'
  s3_sync.region                     = 'type region here'
  s3_sync.aws_access_key_id          = 'type access here'
  s3_sync.aws_secret_access_key      = 'type secret here'
  s3_sync.prefix                     = 'type path here'
  s3_sync.after_build                = true
end
```

## CSS

- Sass
- reset Meyer
- bootstrap 3 (pas foundation, etc)

## JS
- js pur es5 (pas encore es6)
- si besoin jquery  
- si besoin Angular 1 ou Vue, à confirmer
