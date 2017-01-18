module ShiftCommerce
  module CheckCanonicalPath

    def check_canonical_path_for(object)
      if object.respond_to?(:archived) && object.archived
        render 410
      elsif request.path != object.canonical_path
        redirect_to object.canonical_path, status: :moved_permanently
        return
      end
    end
    
  end
end