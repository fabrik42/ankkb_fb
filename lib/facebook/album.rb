class Facebook::Album < Facebook::GraphObject

  attr_accessor :photos

  def description
    data["description"] || name
  end

  def type
    data["type"]
  end

  def cover
    "http://graph.facebook.com/#{id}/picture"
  end

  class << self

    def find(id)
      album_data, photos = cache(id) do
        graph.batch do |batch_api|
          batch_api.get_object(id)
          batch_api.get_connections(id, "photos", :limit => 200)
        end
      end

      new(album_data).tap do |album|
        album.photos = photos.collect{|photo_data| Facebook::Photo.new photo_data }
      end
    end

    def all
      albums = cache("collection") do
        graph.get_connections(settings.facebook["page_id"], "albums")
      end.collect{ |album| new album }

      # sort out profile images
      albums.reject{|album| exclude_album? album }
    end

    def exclude_album?(album)
      if album.type == "profile"
        true
      elsif album.name == "Cover Photos"
        true
      else
        false
      end
    end

  end

end
