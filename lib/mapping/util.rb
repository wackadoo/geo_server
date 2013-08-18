module Mapping
  
  module Util
  
    # calculates the distance between two map coordinates.
    def self.map_distance(lat1, lon1, lat2, lon2)
    
      radius_earth = 6371.0              # in km
    
      lat1r = lat1 / 180.0 * Math::PI    # convert degrees to radians
      lat2r = lat2 / 180.0 * Math::PI

      lon1r = lon1 / 180.0 * Math::PI
      lon2r = lon2 / 180.0 * Math::PI
        
      return Math.acos(Math.sin(lat1r)*Math.sin(lat2r) +       # using the most simple formula. the result's precision highly depends on float's precision
                       Math.cos(lat1r)*Math.cos(lat2r) *
                       Math.cos(lon2r-lon1r)) * radius_earth
    
    end
  end
end