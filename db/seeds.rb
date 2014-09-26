Gnoibox::Author.where(email: 'info@gnoibox.com').first_or_create(password: 'gnbxgnbx', role: 'admin')
