Guides
======

<!-- MarkdownTOC -->

- Configuration standard des ordinateurs des développeurs
    - Gestionnaire de package
    - Gestionnaires de version de Ruby
    - Base de données Postgresql
    - Editeur de code
    - Gestionnaire de version de Node
- Back end
    - App
    - Authentification
    - Attachments
    - Storage
    - Eviter l'injection javascript
    - Export Excel
    - Mails transactionnels
    - Syntaxe
    - Infrastructure
        - Gemfile
        - Redis
- Front end
    - Gestion des assets
    - Chargement des dépendances
    - Livraison
    - CSS
    - JS
    - Large files
    - Gestion des dépendances javascript
- Sources et références

<!-- /MarkdownTOC -->





# Configuration standard des ordinateurs des développeurs

## Gestionnaire de package

Possibilités: Macports, Homebrew

Solution validée: Homebrew https://brew.sh/index_fr.html

## Gestionnaires de version de Ruby

Possibilités: RVM, RBENV

Solution validée : rbenv https://github.com/rbenv/rbenv

## Base de données Postgresql 

Possibilités: binaires, homebrew, PostgresApp

Solution validée: PostgresApp https://postgresapp.com/

## Editeur de code

Possibilités: Notepad++, Sublime Text, Atom, Visual Studio, Eclipse, Komodo...

Solution validée: aucune en particulier, tant que les fichiers générés par l'éditeur sont ajoutés au .gitignore

## Gestionnaire de version de Node

Possibilités: NVM

Solution validée: NVM https://github.com/creationix/nvm







# Back end

## App

rails 5.2

## Authentification

devise

## Attachments

activestorage

## Storage

AWS-SDK (v2)

## Eviter l'injection javascript 

    def sanitize_fields
      full_sanitizer = Rails::Html::FullSanitizer.new
      white_list = Rails::Html::WhiteListSanitizer.new

      # Only text allowed
      self.email = full_sanitizer.sanitize(self.email)
      self.name = full_sanitizer.sanitize(self.name)
      self.firstname = full_sanitizer.sanitize(self.firstname)
      self.gender = full_sanitizer.sanitize(self.gender)
      self.mobile = full_sanitizer.sanitize(self.mobile)
      self.pos = full_sanitizer.sanitize(self.pos)
      self.address = full_sanitizer.sanitize(self.address)
      self.zipcode = full_sanitizer.sanitize(self.zipcode)
      self.city = full_sanitizer.sanitize(self.city)
    end

## Export Excel

/config/initializers/mime_types.rb

    Mime::Type.register "application/xls", :xls

Rien de spécial dans les routes

Pour lier dans une vue

    <%= link_to 'Sponsorings', admin_sponsorings_path(format: :xls) %>

/controllers/admin/users_controller.rb

    class Admin::UsersController < Admin::ApplicationController
        respond_to do |format|
          format.xls { @sponsorings = Sponsoring.export_for_country @filter_country }
        end
    end

/views/admin/users/sponsorings.xls.erb

    <?xml version="1.0"?>
    <Workbook xmlns="urn:schemas-microsoft-com:office:spreadsheet"
      xmlns:o="urn:schemas-microsoft-com:office:office"
      xmlns:x="urn:schemas-microsoft-com:office:excel"
      xmlns:ss="urn:schemas-microsoft-com:office:spreadsheet"
      xmlns:html="http://www.w3.org/TR/REC-html40">
      <Worksheet ss:Name="Sheet1">
        <Table>
          <Row>
            <% keys = @sponsorings.try(:first).try(:keys) || [] %>
            <% keys.each do |name| %>
                <Cell><Data ss:Type="String"><%= name %></Data></Cell>
            <% end %>
        </Row>
        <% @sponsorings.each do |sponsoring| %>
          <Row>
            <% sponsoring.values.each do |value| %>
                <Cell><Data ss:Type="String"><%= value %></Data></Cell>
            <% end %>
          </Row>
        <% end %>
        </Table>
      </Worksheet>
    </Workbook>

## Mails transactionnels

Addon Sendgrid in Heroku

https://devcenter.heroku.com/articles/sendgrid#ruby

## Syntaxe

Pas de `<%-`, c'est idem à `<%`

## Infrastructure

### Gemfile

```
# Infrastructure
gem 'puma'                       # Server
gem 'pg', '0.21.0'               # Database
gem 'bugsnag'                    # Exception catching
gem 'redis-rails'                # Cache db
gem 'newrelic_rpm'               # Apdex
```

### Redis
Policy should be allkeys-lru (https://devcenter.heroku.com/articles/heroku-redis#maxmemory-policy)
```
heroku redis:maxmemory --policy allkeys-lru
```





# Front end

## Gestion des assets

Possibilités: Codekit, grunt, gulp, fire.app, Middleman

Solution validée: Middleman

yarn
middleman
bootstrap 4
jquery 3

## Chargement des dépendances

On inclut les dépendances avec Sprockets.

/Gemfile
```
gem 'middleman-sprockets'
```
/config.rb
```
activate :sprockets
activate :relative_assets

sprockets.append_path File.join "#{root}", 'node_modules'
```
En tête du fichier .js, appeler les dépendences avec un require, par exemple :
```
//= require modernizr.js
```

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
- bootstrap 4 (pas foundation, etc)

## JS

- js pur es5 (pas encore es6)
- si besoin jquery 3
- si besoin Angular 1

## Large files

https://git-lfs.github.com/
```
git lfs track "*.mp4"
```

## Gestion des dépendances javascript

Le dossier node_modules doit être commit. Pas de .gitignore dessus.

Il y a beaucoup de débat sur le sujet (cf https://www.quora.com/Should-I-put-node_modules-in-gitignore), pas de consensus clair. 
Le fait de le commit permet d'avoir en permanence un dossier fonctionnel, même des années après. 




# Sources et références

https://github.com/bbatsov/ruby-style-guide
https://github.com/thoughtbot/guides


* [CSSReference.io](http://cssreference.io)
* [MaintainableCSS](http://maintainablecss.com)
* [MarkSheet](http://marksheet.io)
* [Leveling up in CSS](https://medium.freecodecamp.com/leveling-up-css-44b5045a2667#.nhxv8jpq8)
* [How well do you know CSS display?](https://www.chenhuijing.com/blog/how-well-do-you-know-display/#=~)

