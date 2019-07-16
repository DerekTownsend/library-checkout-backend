class LibraryItemSerializer
  def initialize(library_item_object)
    @library_item = library_item_object
  end

  def to_serialized_json
    obj =
    {
       include:
       {
        libraryable:
          {
            except: %i[created_at updated_at]
          },
        reservations:
          {
            except: %i[created_at updated_at]
          }
        },
      except: %i[created_at updated_at libraryable_id]
    }

    @library_item.to_json(obj)
  end
end
