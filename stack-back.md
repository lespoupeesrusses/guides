# Configuration standard pour les projets avec du back-end

## App

rails 5.1

## Authentification

devise

## Attachments

paperclip

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
