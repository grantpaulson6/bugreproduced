class Post < ApplicationRecord
  def self.comment
    "---\ncomment:\nsensitivity: confidential\nsanitizer: :randomize_digits\nsanitizer_options:\n  :pattern: '12345'\n"
  end
end
