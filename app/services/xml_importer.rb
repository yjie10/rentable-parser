require 'nokogiri'

class XmlImporter
  def initialize(file_path)
    @file_path = file_path
  end

  def import
    doc = Nokogiri::XML(File.read(@file_path))

    doc.xpath('//PhysicalProperty/Property').each do |property|
      city = property.at_xpath('PropertyID/Address/City')&.text&.strip&.downcase
      next unless city == 'madison'

      property_id = property.at_xpath('PropertyID/Identification/@IDValue')&.value
      next if property_id.blank? || Property.exists?(property_id: property_id) # check for duplicate data

      name = property.at_xpath('PropertyID/MarketingName')&.text&.strip
      email = property.at_xpath('PropertyID/Email')&.text&.strip

      # handle bedrooms
      floorplans = property.xpath('Floorplan')
      bedrooms = floorplans.map { |fp| fp.at_xpath('Room[@RoomType="Bedroom"]/Count')&.text&.to_f }.compact.max

      Property.create!(
        property_id: property_id,
        name: name,
        email: email,
        bedrooms: bedrooms
        )
    end

    nil
  end
end
