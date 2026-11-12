module Pagination
  extend ActiveSupport::Concern

  included do
    def paginate(collection, page, per_page)
      collection.page(page).per(per_page)
    end
  end
end