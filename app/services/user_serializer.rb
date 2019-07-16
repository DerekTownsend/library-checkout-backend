class UserSerializer
  def initialize(user_object)
    @user = user_object
  end

  def to_serialized_json
    obj =
    {
       include:
       {
        userable:
          {
            except: %i[created_at updated_at]
          },
          library_items:
            {
              except: %i[created_at updated_at]
            },
          reservations:
            {
              include:
              {
                library_item:{
                  except: %i[created_at updated_at]
                }
              },except: %i[created_at updated_at]
            },
        },
      except: %i[created_at updated_at userable]
    }

    @user.to_json(obj)
  end
end
