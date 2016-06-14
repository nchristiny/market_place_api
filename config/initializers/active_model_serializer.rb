# This was added to due deprecation warning on embed
####
# "The use of .embed method on a Serializer will be soon removed, as this should
# have a global scope and not a class scope.""
# "Please use the global .setup method instead"
# This was ultimately not needed since installing active_model_serializers 0.8.3 (was 0.9.4)
# and adding "embed :ids" back to user serializer.

# ActiveModel::Serializer.setup do |config|
#   config.embed = :ids
#   config.embed_in_root = true
# end


