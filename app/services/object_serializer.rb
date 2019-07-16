class ObjectSerializer
  def initialize(object)
    @object = object
  end

  def to_serialized_json
    obj = { include: {
      library_item: {
      except: %i[created_at updated_at libraryable_id]
      }
    }, except: %i[created_at updated_at] }

    @object.to_json(obj)
  end
end
