Guides
======

<!-- MarkdownTOC -->

- Configuration standard des ordinateurs des développeurs
    - Gestionnaire de package
    - Gestionnaires de version de Ruby
    - Base de données Postgresql
    - Editeur de code
    - Gestionnaire de version de Node
    - Gros fichiers
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
    - Infrastructure
        - Middleman
    - Composants
        - Carousel/Slider : ?
        - File upload
            - Pour jQuery: Dropzone.js \(http://www.dropzonejs.com/\)
            - Pour AngularJS: ng-file-upload \(https://github.com/danialfarid/ng-file-upload/\)
        - Nav de one page avec ancres: Scrollspy
        - Animations au scroll: ScrollReveal
        - Animations en séquence: ?
        - Notices en popin: toastr
        - Images en popin: natif bootstrap
        - Interactions mobiles
        - Mises en page spécifiques \(type pinterest\)
    - Assets
        - Dépendances
        - Javascript
            - Package manager: Yarn
            - Version de javascript: ES5
            - Librairie légère: jQuery 3
            - Framework léger: AngularJS \(Angular 1\)
            - Framework lourd: ?
        - Stylesheets
            - Reset: Eric Meyer
            - Préprocesseur: SASS
            - Framework: Bootstrap 4
            - Méthodologie: BEM
        - Images
            - Svg
        - Videos
        - Icons
    - Déploiement
        - Staging
        - Production
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

## Gros fichiers

https://git-lfs.github.com/
```
git lfs track "*.mp4"
```




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

## Infrastructure

### Middleman 

Gestion (minification, concaténation, rangement...)

Autres possibilités: Codekit, grunt, gulp, fire.app, Middleman

## Composants

### Carousel/Slider : ?

Possibilités : Bootstrap carousel (très limité), Owl (fonctionne correctement), Slick (en cours de test), Siema (pas de dépendance jQuery)

### File upload

#### Pour jQuery: Dropzone.js (http://www.dropzonejs.com/)
Autres possibilités: Dropfile (http://adodson.com/dropfile/)

#### Pour AngularJS: ng-file-upload (https://github.com/danialfarid/ng-file-upload/)
Autres possibilités: https://github.com/nervgh/angular-file-upload/

### Nav de one page avec ancres: Scrollspy
Autres possibilités: Gumshoe (avec SmoothScro)

### Animations au scroll: ScrollReveal
ScrollReveal pour les animations au scroll

### Animations en séquence: ?
Greensock Tween (très lourd mais compat ie9)

### Notices en popin: toastr

### Images en popin: natif bootstrap
Autres possibilités: Fancybox

### Interactions mobiles
Hammer.js
jQuery mobile (catastrophique sur My Redken)

### Mises en page spécifiques (type pinterest)
Masonry
CSS Flex

## Assets

### Dépendances 

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

### Javascript

#### Package manager: Yarn
Alternatives refusées: NPM (trop lent)

Le dossier node_modules ne doit pas être commit, il faut l'ajouter au .gitignore.

Il y a des débats sur le sujet: 
https://www.quora.com/Should-I-put-node_modules-in-gitignore
https://chaseadams.io/2015/07/my-gitignore-conventions/
...
Certes, le fait de le commit permet d'avoir en permanence un dossier fonctionnel, même des années après. 
Le fait de ne pas le commit respecte le principe de la liste des dépendances. Si on utilise un gestionnaire de dépendance, on le fait correctement. Sinon on n'en utilise pas.

Les .gitignore par défaut de Github Node et Rails ajoutent node_modules/.


#### Version de javascript: ES5
Alternatives refusées: ES6 avec Babel et le cortège d'outils pour transpiler.

- js pur es5 (pas encore es6)
- si besoin jquery 3
- si besoin Angular 1
- yarn

#### Librairie légère: jQuery 3

#### Framework léger: AngularJS (Angular 1)
Alternatives refusées: Angular 2 (trop typescript, trop verbeux, sans amélioration en contrepartie), Ember (trop compliqué), React (trop compliqué), Vue (trop dépendant d'ES6), Backbone (syntaxe toute pourrie, peu de features)

#### Framework lourd: ?
Si on a besoin d'un framework lourd, ne devrions nous pas faire du js vanille? Sujet compliqué, à discuter au cas par cas. En fonction des specs, React ou Vue peuvent-être de bons choix.

### Stylesheets

#### Reset: Eric Meyer
Alternatives refusées: Normalize 
Sauf si on utilise Bootsrap, auqeul cas Normalize est inclus

#### Préprocesseur: SASS
Alternatives refusées: Less (trop de syntaxe)

#### Framework: Bootstrap 4
Alternatives refusées: Bootstrap 3 (sauf legacy), Foundation, Zurb
On utilise un framework pour écrire moins de code CSS et JS, donc pas la peine de le mettre pour l'ignorer et tout réécrire.

#### Méthodologie: BEM
Alternative refusées: SMACSS
Attention, BEM est difficilement compatible avec Bootstrap, et orienté application client. Ce n'est pas un bon choix pour un pur markup sémantique.

### Images

Compression
png / jpg

#### Svg
Les svg sont pratiques pour l'indépendance de résolution, pour l'animation, et pour l'interactivité.

2 cas : 
- soit on l'utilise comme une icône/image, et on l'intègre avec une balise img
- soit on l'utilise de manière plus créative, et on l'intègre inline (gem 'inline_svg')
Objectif : pouvoir manipuler le svg comme on veut, et le mettre en cache (donc pas inline).

### Videos

mp4 ou Vimeo/Youtube

### Icons

font-awesome

## Déploiement

### Staging

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

### Production

Plusieurs possibilités, mais la meilleure à l'heure actuelle est Netlify.
Le déploiement se fait au commit, donc il faut une branche dev une fois le site en prod.




# Sources et références

https://github.com/bbatsov/ruby-style-guide
https://github.com/thoughtbot/guides


* [CSSReference.io](http://cssreference.io)
* [MaintainableCSS](http://maintainablecss.com)
* [MarkSheet](http://marksheet.io)
* [Leveling up in CSS](https://medium.freecodecamp.com/leveling-up-css-44b5045a2667#.nhxv8jpq8)
* [How well do you know CSS display?](https://www.chenhuijing.com/blog/how-well-do-you-know-display/#=~)

