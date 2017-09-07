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
